variable "ami"{
    type = string
    default = "ami-066784287e358dad1"
}

variable "type"{
    type = string
    default = "t3.large" 
}

variable "key_pair_name"{
    type = string
    default = "Firstkeypair"
}

variable "name"{
    type = string
    default = "first module"
}

variable "subnet_id" {
  
}

variable "security_groups" {
  
}