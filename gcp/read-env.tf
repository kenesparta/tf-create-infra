data "external" "env_vars" {
  program = ["python", "./read_env.py"]
}
