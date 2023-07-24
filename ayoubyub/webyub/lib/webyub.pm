package webyub;
use Dancer ':syntax';

our $VERSION = '0.1';


#https://www.educba.com/lua-http/?source=leftnav
use AnyEvent;

my %timers;
my $count = 5;
get '/drums' => sub {
    delayed {
        print "Stretching...\n";
        flush; # necessary, since we're streaming

        $timers{'Snare'} = AE::timer 1, 1, delayed {
            $timers{'HiHat'} ||= AE::timer 0, 0.5, delayed {
                content "Tss...\n";
            };

            content "Bap!\n";

            if ( $count-- == 0 ) {
                %timers = ();
                content "Tugu tugu tugu dum!\n";
                done;

                print "<enter sound of applause>\n\n";
                $timers{'Applause'} = AE::timer 3, 0, sub {
                    # the DSL will not available here
                    # because we didn't call the "delayed" keyword
                    print "<applause dies out>\n";
                };
            }
        };
    };
};

get '/' => sub {
  get '/' => sub {
    my $q = param('q');
    if (defined $q) {
        return "You said: $q";
    }
    template 'index';
};
};





get  '/yubhub'   => sub {


  template 'yubhup';



};


get '/user/:id[Int]' => sub {
    # matches /user/34 but not /user/jamesdean
    my $user_id = route_parameters->get('id');
};

get '/user/:username[Str]' => sub {
    # matches /user/jamesdean but not /user/34 since that is caught
    # by previous route
    my $username = route_parameters->get('username');
};


get '/follow/:name?' => sub {
    my $name = route_parameters->get('name') // 'Whoever you are';
    return "Hello there, $name";
};
get '/hello/:name' => sub {
    return "Hi there " . route_parameters->get('name');
};

get '/s' => sub {
    my $q = param('q');
    if (defined $q) {
        return "You said: $q";
    }
    template 'index';
};

true;
