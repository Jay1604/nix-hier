let
  jay = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYss7FXFPP3RVd2mRYNQQfjTYshzU/gA2YXqGsOR9XW jay@orca";
  users = [ jay ];

in
{
  "secret1.age".publicKeys = [ jay ];
}
