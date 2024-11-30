terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25"
    }
  }
  required_version = ">= 1.2.5"
}
provider "aws" {
  region = "ap-southeast-1"
}

# resource "aws_iam_user" "users" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

# variable "user_names" {
#   description = "Create IAM users"
#   type        = list(string)
#   default     = ["Manh", "United"]
# }

resource "aws_iam_user" "users" {
  for_each = var.user_names
  name     = each.key
  path     = each.value.path
  tags     = each.value.tags
}

variable "user_names" {
  type = map(object({
    path = string,
    tags = map(string)
  }))
  default = {
    "Paul" = {
      path = "/sales/"
      tags = {
        "email"  = "paul@acme.com"
        "mobile" = "0902209011"
      }
    }
    "John" = {
      path = "/marketing/"
      tags = {
        "email"  = "john@acme.com"
        "mobile" = "0902209012"
      }
    }
  }
}

output "dirac_arn" {
  value       = aws_iam_user.users[keys(aws_iam_user.users)[0]]
  description = "All Users"
}

# output "all_arns" {
#   value       = aws_iam_user.users[*]
#   description = "The ARNs for all users"
# }
