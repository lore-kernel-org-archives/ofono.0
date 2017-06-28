Content-Type: multipart/mixed; boundary="===============6393481307430614960=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] sim: fix crash in case of invalid sim password type
Date: Wed, 28 Jun 2017 09:46:42 +0200
Message-ID: <1498636003-24999-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6393481307430614960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have an old  Swedish SIM card here that I tried to put in my MC7304 modem.
My ofono version is 1.20 (with some additional patches).
It sometimes return an invalid SIM password type.
After that, ofono crashes. Here is an extract of debug traces when this hap=
pens.
Ofono is just starting, modem was here before ofono starts.

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_attributes() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/devinfo.c:string_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/devinfo.c:qmi_query_serial() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:get_file_attributes_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.err ofonod[1120]: Requested file str=
ucture differs from SIM: 6fb7
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/voice=
call.c:ecc_g2_read_cb() 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_attributes() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/devinfo.c:get_ids_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:get_file_attributes_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/voice=
call.c:ecc_g3_read_cb() 1
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/voice=
call.c:ecc_g3_read_cb() 1
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/voice=
call.c:ecc_g3_read_cb() 1
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/voice=
call.c:ecc_g3_read_cb() 1
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_record() file id 0x6fb7 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/voice=
call.c:ecc_g3_read_cb() 1
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_attributes() file id 0x2fe2 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:get_file_attributes_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_transparent() file id 0x2fe2 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/simfs=
.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_attributes() file id 0x6f05 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:get_file_attributes_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_transparent() file id 0x6f05 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/simfs=
.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 6
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_attributes() file id 0x2f05 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:get_file_attributes_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_read_transparent() file id 0x2f05 path len 0
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:read_generic_cb() =

Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/simfs=
.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 6
Jun 27 15:28:41 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:qmi_query_passwd_state() =

Jun 27 15:28:42 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:get_card_status() info1->app_state:0x6: OFONO_SIM_PASSWORD_IN=
VALID
Jun 27 15:28:42 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/drivers/q=
mimodem/sim.c:query_passwd_state_cb() passwd state 16
Jun 27 15:28:42 klk-lpbs-0504B4 daemon.debug ofonod[1120]: ../git/src/sim.c=
:sim_pin_query_cb() sim->pin_type: 0, pin_type: 16
Jun 27 15:28:42 klk-lpbs-0504B4 daemon.err ofonod[1120]: Aborting (signal 1=
1) [/usr/sbin/ofonod]

Problem is just that we don't have a string corresponding to this password =
type.

Christophe Ronco (1):
  sim: fix crash in case of invalid sim password type

 src/sim.c | 1 +
 1 file changed, 1 insertion(+)

-- =

2.7.4


--===============6393481307430614960==--

