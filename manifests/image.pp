
# 
# $docker_url  = 'false',
# Defines url to download tarball from, see docker::image docker_tar param documentation
# 
# $docker_url_tarball_name = 'false'
# Downloaded tarball name to be passed as docker_tar to docker::image, TODO: parse it from url
# 

define docker_config::image(
    $ensure      = 'present',
    $image       = $title,
    $image_tag   = 'false',
    $force       = 'false',
    $docker_file = 'false',
    $docker_dir  = 'false',
    $docker_tar  = 'false',
    $docker_url  = 'false',
    $docker_url_tarball_name = 'false',
    $docker_repo_url = 'false',
    $docker_repo_dir = 'false',
){
    include docker_config

    if ($docker_repo_url != 'false'){
        if ($docker_repo_dir == 'false'){
            fail('Please provide $docker_repo_dir')
        }
        include git
        exec {
            "git_clone_${docker_repo_url}_for_${name}":
                command => "git clone ${docker_repo_url}",
                unless  => ["test -d ${docker_repo_dir}"],
        }
        $real_docker_dir = $docker_repo_dir
    } else {
        $real_docker_dir = $docker_dir
    }



    if ($docker_tar != 'false' and $docker_url != 'false' ){
        fail('docker_config::image can not have both $docker_tar and $docker_url set')
    }

    # download tarball from url
    if( $docker_url != 'false' ){
        if ($docker_url_tarball_name == 'false'){
            fail('Please provide $docker_url_tarball_name')
        }
        exec {
            "download_docker_image_from_url_${docker_url}":
                command => "curl '${docker_url}'",
                unless  => ["test -f ${docker_url_tarball_name}"],
        }
        $real_docker_tar = $docker_url_tarball_name
    } else {
        $real_docker_tar = $docker_tar
    }

    if ($image_tag == 'false'){
        $real_image_tag = undef
    } else {
        $real_image_tag = $image_tag
    }

    $real_force = str2bool($force)

    if ($docker_file == 'false'){
        $real_docker_file = undef
    } else {
        $real_docker_file = $docker_file
    }

    if ($real_docker_dir == 'false'){
        $real_docker_directory = undef
    } else {
        $real_docker_directory = $real_docker_dir
    }

    if ($real_docker_tar == 'false'){
        $real_docker_tarball = undef
    } else {
        $real_docker_tarball = $real_docker_tar
    }

    docker::image{ $name:
        ensure      => $ensure,
        image       => $image,
        image_tag   => $real_image_tag,
        force       => $real_force,
        docker_file => $real_docker_file,
        docker_dir  => $real_docker_directory,
        docker_tar  => $real_docker_tarball,
    }

}