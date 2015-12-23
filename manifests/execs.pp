# docker_config::execs
class docker_config::execs($execs) {
  create_resources(docker_config::exec, $execs)
}