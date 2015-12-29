
# 
# $docker_url  = 'false',
# Defines url to download tarball from, see docker::image docker_tar param documentation
# 
# $docker_url_tarball_name = 'false'
# Downloaded tarball name to be passed as docker_tar to docker::image, TODO: parse it from url
# 

define docker_config::exec(
    $detach = 'false',
    $interactive = 'false',
    $tty = 'false',
    $container = 'false',
    $command = 'false',
    $sanitise_name = 'true',
){
    include docker_config

    $real_detach = str2bool($detach)
    $real_interactive = str2bool($interactive)
    $real_tty = str2bool($tty)
    $real_sanitise_name = str2bool($sanitise_name)

    if ($container == 'false'){
        $real_container = undef
    } else {
        $real_container = $container
    }

    if ($command == 'false'){
        $real_command = undef
    } else {
        $real_command = $command
    }
    
    docker::exec{ $name:
        detach        => $real_detach,
        interactive   => $real_interactive,
        tty           => $real_tty,
        container     => $real_container,
        command       => $real_command,
        sanitise_name => $real_sanitise_name,
    }

}