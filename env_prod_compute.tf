# Create Varnish server for PROD (Except Varnish Throttle)
resource "aws_instance" "prod-varnish1" {
  ami                    = "${data.aws_ami.prod-varnish1.id}"
  instance_type          = "${var.ec2_prod_varnish1_type}"
  tags { Name = "${element(var.ec2_prod_varnish1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_varnish1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_varnish1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-varnish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_varnish_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-varnish1_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish1_p1_id}"]}
  filter { name = "${var.ebs_prod_varnish1_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish1_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish1_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_varnish1_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish1_p1.snapshot_id}"
    type = "${var.ebs_prod_varnish1_p1_type}"
    tags { Name = "${var.ebs_prod_varnish1_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish1_p1" {
  device_name = "${var.ebs_prod_varnish1_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish1_p1.id}"
  instance_id = "${aws_instance.prod-varnish1.id}"
}
data "aws_ebs_snapshot" "prod-varnish1_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish1_p2_id}"]}
  filter { name = "${var.ebs_prod_varnish1_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish1_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish1_p2" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_varnish1_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish1_p2.snapshot_id}"
    type = "${var.ebs_prod_varnish1_p2_type}"
    tags { Name = "${var.ebs_prod_varnish1_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish1_p2" {
  device_name = "${var.ebs_prod_varnish1_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish1_p2.id}"
  instance_id = "${aws_instance.prod-varnish1.id}"
}

resource "aws_instance" "prod-varnish2" {
  ami                    = "${data.aws_ami.prod-varnish2.id}"
  instance_type          = "${var.ec2_prod_varnish2_type}"
  tags { Name = "${element(var.ec2_prod_varnish2_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_varnish2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_varnish2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-varnish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_varnish_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-varnish2_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish2_p1_id}"]}
  filter { name = "${var.ebs_prod_varnish2_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish2_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish2_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_varnish2_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish2_p1.snapshot_id}"
    type = "${var.ebs_prod_varnish2_p1_type}"
    tags { Name = "${var.ebs_prod_varnish2_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish2_p1" {
  device_name = "${var.ebs_prod_varnish2_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish2_p1.id}"
  instance_id = "${aws_instance.prod-varnish2.id}"
}
data "aws_ebs_snapshot" "prod-varnish2_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish2_p2_id}"]}
  filter { name = "${var.ebs_prod_varnish2_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish2_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish2_p2" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_varnish2_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish2_p2.snapshot_id}"
    type = "${var.ebs_prod_varnish2_p2_type}"
    tags { Name = "${var.ebs_prod_varnish2_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish2_p2" {
  device_name = "${var.ebs_prod_varnish2_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish2_p2.id}"
  instance_id = "${aws_instance.prod-varnish2.id}"
}

resource "aws_instance" "prod-varnish3" {
  ami                    = "${data.aws_ami.prod-varnish3.id}"
  instance_type          = "${var.ec2_prod_varnish3_type}"
  tags { Name = "${element(var.ec2_prod_varnish3_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_varnish3_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 2)}"
  private_ip             = "${element(var.ec2_prod_varnish3_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-varnish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_varnish_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-varnish3_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish3_p1_id}"]}
  filter { name = "${var.ebs_prod_varnish3_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish3_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish3_p1" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_varnish3_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish3_p1.snapshot_id}"
    type = "${var.ebs_prod_varnish3_p1_type}"
    tags { Name = "${var.ebs_prod_varnish3_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish3_p1" {
  device_name = "${var.ebs_prod_varnish3_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish3_p1.id}"
  instance_id = "${aws_instance.prod-varnish3.id}"
}
data "aws_ebs_snapshot" "prod-varnish3_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish3_p2_id}"]}
  filter { name = "${var.ebs_prod_varnish3_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish3_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish3_p2" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_varnish3_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish3_p2.snapshot_id}"
    type = "${var.ebs_prod_varnish3_p2_type}"
    tags { Name = "${var.ebs_prod_varnish3_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish3_p2" {
  device_name = "${var.ebs_prod_varnish3_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish3_p2.id}"
  instance_id = "${aws_instance.prod-varnish3.id}"
}

resource "aws_instance" "prod-varnish4" {
  ami                    = "${data.aws_ami.prod-varnish4.id}"
  instance_type          = "${var.ec2_prod_varnish4_type}"
  tags { Name = "${element(var.ec2_prod_varnish4_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_varnish4_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 3)}"
  private_ip             = "${element(var.ec2_prod_varnish4_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-varnish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_varnish_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-varnish4_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish4_p1_id}"]}
  filter { name = "${var.ebs_prod_varnish4_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish4_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish4_p1" {
    availability_zone = "${element(var.azs_prod, 3)}"
    size = "${var.ebs_prod_varnish4_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish4_p1.snapshot_id}"
    type = "${var.ebs_prod_varnish4_p1_type}"
    tags { Name = "${var.ebs_prod_varnish4_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish4_p1" {
  device_name = "${var.ebs_prod_varnish4_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish4_p1.id}"
  instance_id = "${aws_instance.prod-varnish4.id}"
}
data "aws_ebs_snapshot" "prod-varnish4_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish4_p2_id}"]}
  filter { name = "${var.ebs_prod_varnish4_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish4_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish4_p2" {
    availability_zone = "${element(var.azs_prod, 3)}"
    size = "${var.ebs_prod_varnish4_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish4_p2.snapshot_id}"
    type = "${var.ebs_prod_varnish4_p2_type}"
    tags { Name = "${var.ebs_prod_varnish4_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish4_p2" {
  device_name = "${var.ebs_prod_varnish4_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish4_p2.id}"
  instance_id = "${aws_instance.prod-varnish4.id}"
}

# Create Varnish throttle server for PROD
resource "aws_instance" "prod-varnish-th" {
  ami                    = "${data.aws_ami.prod-varnish-th.id}"
  instance_type          = "${var.ec2_prod_varnish_th_type}"
  tags { Name = "${element(var.ec2_prod_varnish_th_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_varnish_th_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_varnish_th_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-varnish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_varnish_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-varnish-th_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish_th_p1_id}"]}
  filter { name = "${var.ebs_prod_varnish_th_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish_th_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish-th_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_varnish_th_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish-th_p1.snapshot_id}"
    type = "${var.ebs_prod_varnish_th_p1_type}"
    tags { Name = "${var.ebs_prod_varnish_th_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish-th_p1" {
  device_name = "${var.ebs_prod_varnish_th_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish-th_p1.id}"
  instance_id = "${aws_instance.prod-varnish-th.id}"
}
data "aws_ebs_snapshot" "prod-varnish-th_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_varnish_th_p2_id}"]}
  filter { name = "${var.ebs_prod_varnish_th_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_varnish_th_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-varnish-th_p2" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_varnish_th_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-varnish-th_p2.snapshot_id}"
    type = "${var.ebs_prod_varnish_th_p2_type}"
    tags { Name = "${var.ebs_prod_varnish_th_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-varnish-th_p2" {
  device_name = "${var.ebs_prod_varnish_th_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-varnish-th_p2.id}"
  instance_id = "${aws_instance.prod-varnish-th.id}"
}

# Create Apache server for PROD
resource "aws_instance" "prod-apache1" {
  ami                    = "${data.aws_ami.prod-apache1.id}"
  instance_type          = "${var.ec2_prod_apache1_type}"
  tags { Name = "${element(var.ec2_prod_apache1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_apache1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_apache1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-apache-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_apache1_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-apache1_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache1_p1_id}"]}
  filter { name = "${var.ebs_prod_apache1_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache1_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache1_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_apache1_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache1_p1.snapshot_id}"
    type = "${var.ebs_prod_apache1_p1_type}"
    tags { Name = "${var.ebs_prod_apache1_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache1_p1" {
  device_name = "${var.ebs_prod_apache1_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache1_p1.id}"
  instance_id = "${aws_instance.prod-apache1.id}"
}
data "aws_ebs_snapshot" "prod-apache1_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache1_p2_id}"]}
  filter { name = "${var.ebs_prod_apache1_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache1_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache1_p2" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_apache1_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache1_p2.snapshot_id}"
    type = "${var.ebs_prod_apache1_p2_type}"
    tags { Name = "${var.ebs_prod_apache1_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache1_p2" {
  device_name = "${var.ebs_prod_apache1_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache1_p2.id}"
  instance_id = "${aws_instance.prod-apache1.id}"
}

resource "aws_instance" "prod-apache2" {
  ami                    = "${data.aws_ami.prod-apache2.id}"
  instance_type          = "${var.ec2_prod_apache2_type}"
  tags { Name = "${element(var.ec2_prod_apache2_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_apache2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_apache2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-apache-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_apache2_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-apache2_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache2_p1_id}"]}
  filter { name = "${var.ebs_prod_apache2_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache2_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache2_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_apache2_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache2_p1.snapshot_id}"
    type = "${var.ebs_prod_apache2_p1_type}"
    tags { Name = "${var.ebs_prod_apache2_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache2_p1" {
  device_name = "${var.ebs_prod_apache2_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache2_p1.id}"
  instance_id = "${aws_instance.prod-apache2.id}"
}
data "aws_ebs_snapshot" "prod-apache2_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache2_p2_id}"]}
  filter { name = "${var.ebs_prod_apache2_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache2_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache2_p2" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_apache2_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache2_p2.snapshot_id}"
    type = "${var.ebs_prod_apache2_p2_type}"
    tags { Name = "${var.ebs_prod_apache2_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache2_p2" {
  device_name = "${var.ebs_prod_apache2_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache2_p2.id}"
  instance_id = "${aws_instance.prod-apache2.id}"
}

resource "aws_instance" "prod-apache3" {
  ami                    = "${data.aws_ami.prod-apache3.id}"
  instance_type          = "${var.ec2_prod_apache3_type}"
  tags { Name = "${element(var.ec2_prod_apache3_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_apache3_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 2)}"
  private_ip             = "${element(var.ec2_prod_apache3_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-apache-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_apache3_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-apache3_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache3_p1_id}"]}
  filter { name = "${var.ebs_prod_apache3_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache3_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache3_p1" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_apache3_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache3_p1.snapshot_id}"
    type = "${var.ebs_prod_apache3_p1_type}"
    tags { Name = "${var.ebs_prod_apache3_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache3_p1" {
  device_name = "${var.ebs_prod_apache3_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache3_p1.id}"
  instance_id = "${aws_instance.prod-apache3.id}"
}
data "aws_ebs_snapshot" "prod-apache3_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache3_p2_id}"]}
  filter { name = "${var.ebs_prod_apache3_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache3_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache3_p2" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_apache3_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache3_p2.snapshot_id}"
    type = "${var.ebs_prod_apache3_p2_type}"
    tags { Name = "${var.ebs_prod_apache3_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache3_p2" {
  device_name = "${var.ebs_prod_apache3_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache3_p2.id}"
  instance_id = "${aws_instance.prod-apache3.id}"
}

resource "aws_instance" "prod-apache4" {
  ami                    = "${data.aws_ami.prod-apache4.id}"
  instance_type          = "${var.ec2_prod_apache4_type}"
  tags { Name = "${element(var.ec2_prod_apache4_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_apache4_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 3)}"
  private_ip             = "${element(var.ec2_prod_apache4_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-apache-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_apache4_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-apache4_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache4_p1_id}"]}
  filter { name = "${var.ebs_prod_apache4_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache4_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache4_p1" {
    availability_zone = "${element(var.azs_prod, 3)}"
    size = "${var.ebs_prod_apache4_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache4_p1.snapshot_id}"
    type = "${var.ebs_prod_apache4_p1_type}"
    tags { Name = "${var.ebs_prod_apache4_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache4_p1" {
  device_name = "${var.ebs_prod_apache4_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache4_p1.id}"
  instance_id = "${aws_instance.prod-apache4.id}"
}
data "aws_ebs_snapshot" "prod-apache4_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache4_p2_id}"]}
  filter { name = "${var.ebs_prod_apache4_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache4_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache4_p2" {
    availability_zone = "${element(var.azs_prod, 3)}"
    size = "${var.ebs_prod_apache4_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache4_p2.snapshot_id}"
    type = "${var.ebs_prod_apache4_p2_type}"
    tags { Name = "${var.ebs_prod_apache4_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache4_p2" {
  device_name = "${var.ebs_prod_apache4_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache4_p2.id}"
  instance_id = "${aws_instance.prod-apache4.id}"
}

# Create Apache Author server for PROD
resource "aws_instance" "prod-apache-author-1" {
  ami                    = "${data.aws_ami.prod-apache-author-1.id}"
  instance_type          = "${var.ec2_prod_apache_author-1_type}"
  tags { Name = "${element(var.ec2_prod_apache_author-1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_apache_author-1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_apache_author-1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-apache-author-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_apache_author_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-apache-author-1_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache_author-1_p1_id}"]}
  filter { name = "${var.ebs_prod_apache_author-1_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache_author-1_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache-author-1_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_apache_author-1_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache-author-1_p1.snapshot_id}"
    type = "${var.ebs_prod_apache_author-1_p1_type}"
    tags { Name = "${var.ebs_prod_apache_author-1_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache-author-1_p1" {
  device_name = "${var.ebs_prod_apache_author-1_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache-author-1_p1.id}"
  instance_id = "${aws_instance.prod-apache-author-1.id}"
}
data "aws_ebs_snapshot" "prod-apache-author-1_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache_author-1_p2_id}"]}
  filter { name = "${var.ebs_prod_apache_author-1_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache_author-1_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache-author-1_p2" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_apache_author-1_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache-author-1_p2.snapshot_id}"
    type = "${var.ebs_prod_apache_author-1_p2_type}"
    tags { Name = "${var.ebs_prod_apache_author-1_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache-author-1_p2" {
  device_name = "${var.ebs_prod_apache_author-1_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache-author-1_p2.id}"
  instance_id = "${aws_instance.prod-apache-author-1.id}"
}

# Create Apache Author-2 server for PROD
resource "aws_instance" "prod-apache-author-2" {
  ami                    = "${data.aws_ami.prod-apache-author-2.id}"
  instance_type          = "${var.ec2_prod_apache_author-2_type}"
  tags { Name = "${element(var.ec2_prod_apache_author-2_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_apache_author-2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_apache_author-2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-apache-author-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_apache_author_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-apache-author-2_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache_author-2_p1_id}"]}
  filter { name = "${var.ebs_prod_apache_author-2_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache_author-2_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache-author-2_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_apache_author-2_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache-author-2_p1.snapshot_id}"
    type = "${var.ebs_prod_apache_author-2_p1_type}"
    tags { Name = "${var.ebs_prod_apache_author-2_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache-author-2_p1" {
  device_name = "${var.ebs_prod_apache_author-2_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache-author-2_p1.id}"
  instance_id = "${aws_instance.prod-apache-author-2.id}"
}
data "aws_ebs_snapshot" "prod-apache-author-2_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_apache_author-2_p2_id}"]}
  filter { name = "${var.ebs_prod_apache_author-2_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_apache_author-2_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-apache-author-2_p2" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_apache_author-2_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-apache-author-2_p2.snapshot_id}"
    type = "${var.ebs_prod_apache_author-2_p2_type}"
    tags { Name = "${var.ebs_prod_apache_author-2_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-apache-author-2_p2" {
  device_name = "${var.ebs_prod_apache_author-2_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-apache-author-2_p2.id}"
  instance_id = "${aws_instance.prod-apache-author-2.id}"
}
# Create MSSQL server for PROD
# resource "aws_instance" "prod-mssql1" {
#   ami                    = "${data.aws_ami.prod-mssql1.id}"
#   instance_type          = "${var.ec2_prod_mssql1_type}"
#   count                  = "${length(var.ec2_prod_mssql1_name)}"
#   subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
#   private_ip             = "${element(var.ec2_prod_mssql1_ip, count.index)}"
#   key_name               = "${var.namekey}"
#   iam_instance_profile   = "prod-mssql-iam-profile"
#   vpc_security_group_ids = ["${aws_security_group.sg_mssql_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
#   tags {
#     Name = "${element(var.ec2_prod_mssql1_name, count.index)}"
#     "terraform" = "yes"
#     "env" = "prod"
#     "msp-support" = "level a"
#   }
# }

# resource "aws_instance" "prod-mssql2" {
#   ami                    = "${data.aws_ami.prod-mssql2.id}"
#   instance_type          = "${var.ec2_prod_mssql2_type}"
#   count                  = "${length(var.ec2_prod_mssql2_name)}"
#   subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
#   private_ip             = "${element(var.ec2_prod_mssql2_ip, count.index)}"
#   key_name               = "${var.namekey}"
#   iam_instance_profile   = "prod-mssql-iam-profile"
#   vpc_security_group_ids = ["${aws_security_group.sg_mssql_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
#   tags {
#     Name = "${element(var.ec2_prod_mssql2_name, count.index)}"
#     "terraform" = "yes"
#     "env" = "prod"
#     "msp-support" = "level a"
#   }
# }

# Create Author server for PROD
resource "aws_instance" "prod-author" {
  ami                    = "${data.aws_ami.prod-author.id}"
  instance_type          = "${var.ec2_prod_author_type}"
  tags { Name = "${element(var.ec2_prod_author_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_author_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_author_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-author-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_author_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-author_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_author_p1_id}"]}
  filter { name = "${var.ebs_prod_author_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_author_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-author_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_author_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-author_p1.snapshot_id}"
    type = "${var.ebs_prod_author_p1_type}"
    tags { Name = "${var.ebs_prod_author_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-author_p1" {
  device_name = "${var.ebs_prod_author_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-author_p1.id}"
  instance_id = "${aws_instance.prod-author.id}"
}

resource "aws_instance" "prod-author-cold" {
  ami                    = "${data.aws_ami.prod-author-cold.id}"
  instance_type          = "${var.ec2_prod_author-cold_type}"
  tags { Name = "${element(var.ec2_prod_author-cold_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_author-cold_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_author-cold_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-author-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_author_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-author-cold_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_author-cold_p1_id}"]}
  filter { name = "${var.ebs_prod_author-cold_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_author-cold_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-author-cold_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_author-cold_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-author-cold_p1.snapshot_id}"
    type = "${var.ebs_prod_author-cold_p1_type}"
    tags { Name = "${var.ebs_prod_author-cold_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-author-cold_p1" {
  device_name = "${var.ebs_prod_author-cold_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-author-cold_p1.id}"
  instance_id = "${aws_instance.prod-author-cold.id}"
}

# Create Publish server for PROD
resource "aws_instance" "prod-publish1" {
  ami                    = "${data.aws_ami.prod-publish1.id}"
  instance_type          = "${var.ec2_prod_publish1_type}"
  tags { Name = "${element(var.ec2_prod_publish1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_publish1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_publish1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-publish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_publish1_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-publish1_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_publish1_p1_id}"]}
  filter { name = "${var.ebs_prod_publish1_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_publish1_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-publish1_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_publish1_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-publish1_p1.snapshot_id}"
    type = "${var.ebs_prod_publish1_p1_type}"
    tags { Name = "${var.ebs_prod_publish1_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-publish1_p1" {
  device_name = "${var.ebs_prod_publish1_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-publish1_p1.id}"
  instance_id = "${aws_instance.prod-publish1.id}"
}

resource "aws_instance" "prod-publish2" {
  ami                    = "${data.aws_ami.prod-publish2.id}"
  instance_type          = "${var.ec2_prod_publish2_type}"
  tags { Name = "${element(var.ec2_prod_publish2_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_publish2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_publish2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-publish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_publish2_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-publish2_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_publish2_p1_id}"]}
  filter { name = "${var.ebs_prod_publish2_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_publish2_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-publish2_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_publish2_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-publish2_p1.snapshot_id}"
    type = "${var.ebs_prod_publish2_p1_type}"
    tags { Name = "${var.ebs_prod_publish2_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-publish2_p1" {
  device_name = "${var.ebs_prod_publish2_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-publish2_p1.id}"
  instance_id = "${aws_instance.prod-publish2.id}"
}

resource "aws_instance" "prod-publish3" {
  ami                    = "${data.aws_ami.prod-publish3.id}"
  instance_type          = "${var.ec2_prod_publish3_type}"
  tags { Name = "${element(var.ec2_prod_publish3_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_publish3_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 2)}"
  private_ip             = "${element(var.ec2_prod_publish3_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-publish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_publish3_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-publish3_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_publish3_p1_id}"]}
  filter { name = "${var.ebs_prod_publish3_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_publish3_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-publish3_p1" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_publish3_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-publish3_p1.snapshot_id}"
    type = "${var.ebs_prod_publish3_p1_type}"
    tags { Name = "${var.ebs_prod_publish3_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-publish3_p1" {
  device_name = "${var.ebs_prod_publish3_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-publish3_p1.id}"
  instance_id = "${aws_instance.prod-publish3.id}"
}

resource "aws_instance" "prod-publish4" {
  ami                    = "${data.aws_ami.prod-publish4.id}"
  instance_type          = "${var.ec2_prod_publish4_type}"
  tags { Name = "${element(var.ec2_prod_publish4_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_publish4_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 3)}"
  private_ip             = "${element(var.ec2_prod_publish4_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-publish-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_publish4_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-publish4_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_publish4_p1_id}"]}
  filter { name = "${var.ebs_prod_publish4_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_publish4_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-publish4_p1" {
    availability_zone = "${element(var.azs_prod, 3)}"
    size = "${var.ebs_prod_publish4_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-publish4_p1.snapshot_id}"
    type = "${var.ebs_prod_publish4_p1_type}"
    tags { Name = "${var.ebs_prod_publish4_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-publish4_p1" {
  device_name = "${var.ebs_prod_publish4_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-publish4_p1.id}"
  instance_id = "${aws_instance.prod-publish4.id}"
}

# Create Tomcat server for PROD
resource "aws_instance" "prod-tomcat1" {
  ami                    = "${data.aws_ami.prod-tomcat1.id}"
  instance_type          = "${var.ec2_prod_tomcat1_type}"
  tags { Name = "${element(var.ec2_prod_tomcat1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_tomcat1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_tomcat1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-tomcat-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_tomcat_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-tomcat1_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_tomcat1_p1_id}"]}
  filter { name = "${var.ebs_prod_tomcat1_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_tomcat1_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-tomcat1_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_tomcat1_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-tomcat1_p1.snapshot_id}"
    type = "${var.ebs_prod_tomcat1_p1_type}"
    tags { Name = "${var.ebs_prod_tomcat1_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-tomcat1_p1" {
  device_name = "${var.ebs_prod_tomcat1_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-tomcat1_p1.id}"
  instance_id = "${aws_instance.prod-tomcat1.id}"
}
data "aws_ebs_snapshot" "prod-tomcat1_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_tomcat1_p2_id}"]}
  filter { name = "${var.ebs_prod_tomcat1_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_tomcat1_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-tomcat1_p2" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_tomcat1_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-tomcat1_p2.snapshot_id}"
    type = "${var.ebs_prod_tomcat1_p2_type}"
    tags { Name = "${var.ebs_prod_tomcat1_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-tomcat1_p2" {
  device_name = "${var.ebs_prod_tomcat1_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-tomcat1_p2.id}"
  instance_id = "${aws_instance.prod-tomcat1.id}"
}

resource "aws_instance" "prod-tomcat2" {
  ami                    = "${data.aws_ami.prod-tomcat2.id}"
  instance_type          = "${var.ec2_prod_tomcat2_type}"
  tags { Name = "${element(var.ec2_prod_tomcat2_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_tomcat2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_tomcat2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-tomcat-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_tomcat_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-tomcat2_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_tomcat2_p1_id}"]}
  filter { name = "${var.ebs_prod_tomcat2_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_tomcat2_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-tomcat2_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_tomcat2_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-tomcat2_p1.snapshot_id}"
    type = "${var.ebs_prod_tomcat2_p1_type}"
    tags { Name = "${var.ebs_prod_tomcat2_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-tomcat2_p1" {
  device_name = "${var.ebs_prod_tomcat2_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-tomcat2_p1.id}"
  instance_id = "${aws_instance.prod-tomcat2.id}"
}
data "aws_ebs_snapshot" "prod-tomcat2_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_tomcat2_p2_id}"]}
  filter { name = "${var.ebs_prod_tomcat2_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_tomcat2_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-tomcat2_p2" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_tomcat2_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-tomcat2_p2.snapshot_id}"
    type = "${var.ebs_prod_tomcat2_p2_type}"
    tags { Name = "${var.ebs_prod_tomcat2_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-tomcat2_p2" {
  device_name = "${var.ebs_prod_tomcat2_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-tomcat2_p2.id}"
  instance_id = "${aws_instance.prod-tomcat2.id}"
}

resource "aws_instance" "prod-tomcat3" {
  ami                    = "${data.aws_ami.prod-tomcat3.id}"
  instance_type          = "${var.ec2_prod_tomcat3_type}"
  tags { Name = "${element(var.ec2_prod_tomcat3_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_tomcat3_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 2)}"
  private_ip             = "${element(var.ec2_prod_tomcat3_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-tomcat-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_tomcat_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-tomcat3_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_tomcat3_p1_id}"]}
  filter { name = "${var.ebs_prod_tomcat3_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_tomcat3_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-tomcat3_p1" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_tomcat3_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-tomcat3_p1.snapshot_id}"
    type = "${var.ebs_prod_tomcat3_p1_type}"
    tags { Name = "${var.ebs_prod_tomcat3_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-tomcat3_p1" {
  device_name = "${var.ebs_prod_tomcat3_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-tomcat3_p1.id}"
  instance_id = "${aws_instance.prod-tomcat3.id}"
}
data "aws_ebs_snapshot" "prod-tomcat3_p2" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_tomcat3_p2_id}"]}
  filter { name = "${var.ebs_prod_tomcat3_p2_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_tomcat3_p2_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-tomcat3_p2" {
    availability_zone = "${element(var.azs_prod, 2)}"
    size = "${var.ebs_prod_tomcat3_p2_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-tomcat3_p2.snapshot_id}"
    type = "${var.ebs_prod_tomcat3_p2_type}"
    tags { Name = "${var.ebs_prod_tomcat3_p2_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-tomcat3_p2" {
  device_name = "${var.ebs_prod_tomcat3_p2_partition}"
  volume_id   = "${aws_ebs_volume.prod-tomcat3_p2.id}"
  instance_id = "${aws_instance.prod-tomcat3.id}"
}

# Create MYSQL server for PROD
resource "aws_instance" "prod-mysql1" {
  ami                    = "${data.aws_ami.prod-mysql1.id}"
  instance_type          = "${var.ec2_prod_mysql1_type}"
  tags { Name = "${element(var.ec2_prod_mysql1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_mysql1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_mysql1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-mysql-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_mysql_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-mysql1_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_mysql1_p1_id}"]}
  filter { name = "${var.ebs_prod_mysql1_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_mysql1_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-mysql1_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_mysql1_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-mysql1_p1.snapshot_id}"
    type = "${var.ebs_prod_mysql1_p1_type}"
    tags { Name = "${var.ebs_prod_mysql1_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-mysql1_p1" {
  device_name = "${var.ebs_prod_mysql1_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-mysql1_p1.id}"
  instance_id = "${aws_instance.prod-mysql1.id}"
}

resource "aws_instance" "prod-mysql2" {
  ami                    = "${data.aws_ami.prod-mysql2.id}"
  instance_type          = "${var.ec2_prod_mysql2_type}"
  tags { Name = "${element(var.ec2_prod_mysql2_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_mysql2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_mysql2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-mysql-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_mysql_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-mysql2_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_mysql2_p1_id}"]}
  filter { name = "${var.ebs_prod_mysql2_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_mysql2_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-mysql2_p1" {
    availability_zone = "${element(var.azs_prod, 0)}"
    size = "${var.ebs_prod_mysql2_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-mysql2_p1.snapshot_id}"
    type = "${var.ebs_prod_mysql2_p1_type}"
    tags { Name = "${var.ebs_prod_mysql2_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-mysql2_p1" {
  device_name = "${var.ebs_prod_mysql2_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-mysql2_p1.id}"
  instance_id = "${aws_instance.prod-mysql2.id}"
}

resource "aws_instance" "prod-mysql3" {
  ami                    = "${data.aws_ami.prod-mysql3.id}"
  instance_type          = "${var.ec2_prod_mysql3_type}"
  tags { Name = "${element(var.ec2_prod_mysql3_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_mysql3_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_mysql3_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-mysql-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_mysql_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-mysql3_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_mysql3_p1_id}"]}
  filter { name = "${var.ebs_prod_mysql3_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_mysql3_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-mysql3_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_mysql3_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-mysql3_p1.snapshot_id}"
    type = "${var.ebs_prod_mysql3_p1_type}"
    tags { Name = "${var.ebs_prod_mysql3_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-mysql3_p1" {
  device_name = "${var.ebs_prod_mysql3_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-mysql3_p1.id}"
  instance_id = "${aws_instance.prod-mysql3.id}"
}

resource "aws_instance" "prod-mysql4" {
  ami                    = "${data.aws_ami.prod-mysql4.id}"
  instance_type          = "${var.ec2_prod_mysql4_type}"
  tags { Name = "${element(var.ec2_prod_mysql4_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_mysql4_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_mysql4_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-mysql-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_mysql_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}
data "aws_ebs_snapshot" "prod-mysql4_p1" {
  most_recent = true
  filter { name = "tag:id" values = ["${var.ebs_prod_mysql4_p1_id}"]}
  filter { name = "${var.ebs_prod_mysql4_p1_create == "no" ? "tag:inuse" : "status"}" values = ["${var.ebs_prod_mysql4_p1_create == "no" ? "yes" : "completed"}"]}
}
resource "aws_ebs_volume" "prod-mysql4_p1" {
    availability_zone = "${element(var.azs_prod, 1)}"
    size = "${var.ebs_prod_mysql4_p1_size}"
    snapshot_id = "${data.aws_ebs_snapshot.prod-mysql4_p1.snapshot_id}"
    type = "${var.ebs_prod_mysql4_p1_type}"
    tags { Name = "${var.ebs_prod_mysql4_p1_name}" "terraform" = "yes" "env" = "prod"}
}
resource "aws_volume_attachment" "prod-mysql4_p1" {
  device_name = "${var.ebs_prod_mysql4_p1_partition}"
  volume_id   = "${aws_ebs_volume.prod-mysql4_p1.id}"
  instance_id = "${aws_instance.prod-mysql4.id}"
}

# Create LDAP server for PROD
resource "aws_instance" "prod-ldap" {
  ami                    = "${data.aws_ami.prod-ldap.id}"
  instance_type          = "${var.ec2_prod_ldap_type}"
  count                  = "${length(var.ec2_prod_ldap_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, count.index)}"
  private_ip             = "${element(var.ec2_prod_ldap_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-ldap-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_ldap_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
  tags {
    Name = "${element(var.ec2_prod_ldap_name, count.index)}"
    "terraform" = "yes"
    "env" = "prod"
    "msp-support" = "level a"
  }
}

# Create Usermanager server for PROD
#resource "aws_instance" "prod-usermanager1" {
#  ami                    = "${data.aws_ami.prod-usermanager1.id}"
#  instance_type          = "${var.ec2_prod_usermanager1_type}"
#  count                  = "${length(var.ec2_prod_usermanager1_name)}"
#  subnet_id              = "${element(aws_subnet.public_prod.*.id, 0)}"
#  private_ip             = "${element(var.ec2_prod_usermanager1_ip, count.index)}"
#  key_name               = "${var.namekey}"
#  iam_instance_profile   = "prod-iis-iam-profile"
#  vpc_security_group_ids = ["${aws_security_group.sg_usermanager1_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
#  tags {
#    Name = "${element(var.ec2_prod_usermanager1_name, count.index)}"
#    "terraform" = "yes"
#    "env" = "prod"
#    "msp-support" = "level a"
#  }
#}

#resource "aws_instance" "prod-usermanager2" {
#  ami                    = "${data.aws_ami.prod-usermanager2.id}"
#  instance_type          = "${var.ec2_prod_usermanager2_type}"
#  count                  = "${length(var.ec2_prod_usermanager2_name)}"
#  subnet_id              = "${element(aws_subnet.public_prod.*.id, 1)}"
#  private_ip             = "${element(var.ec2_prod_usermanager2_ip, count.index)}"
#  key_name               = "${var.namekey}"
# iam_instance_profile   = "prod-iis-iam-profile"
#  vpc_security_group_ids = ["${aws_security_group.sg_usermanager2_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
#  tags {
#    Name = "${element(var.ec2_prod_usermanager2_name, count.index)}"
#    "terraform" = "yes"
#    "env" = "prod"
#    "msp-support" = "level a"
#  }
#}

# Create VPN NAT server for PROD
resource "aws_instance" "prod-vpnnat1" {
  ami                    = "${data.aws_ami.prod-vpnnat.id}"
  instance_type          = "${var.ec2_prod_vpnnat1_type}"
  tags { Name = "${element(var.ec2_prod_vpnnat1_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_vpnnat1_name)}"
  subnet_id              = "${element(aws_subnet.public_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_vpnnat1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-vpn-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_vpnnat_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}

/*# Create VPN IPSEC server for PROD
resource "aws_instance" "prod-vpnipsec" {
  ami                    = "${data.aws_ami.prod-vpnipsec.id}"
  instance_type          = "${var.ec2_prod_vpnipsec_type}"
  tags { Name = "${element(var.ec2_prod_vpnipsec_name, count.index)}" "terraform" = "yes" "env" = "prod"}
  count                  = "${length(var.ec2_prod_vpnipsec_name)}"
  subnet_id              = "${element(aws_subnet.public_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_vpnipsec_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-vpn-iam-profile"
  source_dest_check      = false
  vpc_security_group_ids = ["${aws_security_group.sg_vpnipsec_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}"]
}*/

# Create IIS1 server for PROD
resource "aws_instance" "prod-iis1" {
  ami                    = "${data.aws_ami.prod-iis1.id}"
  instance_type          = "${var.ec2_prod_iis1_type}"
  count                  = "${length(var.ec2_prod_iis1_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 0)}"
  private_ip             = "${element(var.ec2_prod_iis1_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-iis-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_iis_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}", "${aws_security_group.sg_www_prod_outbound.id}"]
  tags {
    Name = "${element(var.ec2_prod_iis1_name, count.index)}"
    "terraform" = "yes"
    "env" = "prod"
    "msp-support" = "level a"
  }
}

# Create IIS2 server for PROD
resource "aws_instance" "prod-iis2" {
  ami                    = "${data.aws_ami.prod-iis2.id}"
  instance_type          = "${var.ec2_prod_iis2_type}"
  count                  = "${length(var.ec2_prod_iis2_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 1)}"
  private_ip             = "${element(var.ec2_prod_iis2_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-iis-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_iis_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}", "${aws_security_group.sg_www_prod_outbound.id}"]
  tags {
    Name = "${element(var.ec2_prod_iis2_name, count.index)}"
    "terraform" = "yes"
    "env" = "prod"
    "msp-support" = "level a"
  }
}
# Create IIS3 server for PROD
resource "aws_instance" "prod-iis3" {
  ami                    = "${data.aws_ami.prod-iis3.id}"
  instance_type          = "${var.ec2_prod_iis3_type}"
  count                  = "${length(var.ec2_prod_iis3_name)}"
  subnet_id              = "${element(aws_subnet.private_prod.*.id, 2)}"
  private_ip             = "${element(var.ec2_prod_iis3_ip, count.index)}"
  key_name               = "${var.namekey}"
  iam_instance_profile   = "prod-iis-iam-profile"
  vpc_security_group_ids = ["${aws_security_group.sg_iis_prod.id}", "${aws_security_group.sg_global_prod.id}", "${aws_security_group.sg_ads_prod.id}", "${aws_security_group.sg_www_prod_outbound.id}"]
  tags {
    Name = "${element(var.ec2_prod_iis3_name, count.index)}"
    "terraform" = "yes"
    "env" = "prod"
    "msp-support" = "level a"
  }
}

