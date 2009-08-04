Content-Type: multipart/mixed; boundary="===============4943948243527471379=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Compile error
Date: Tue, 04 Aug 2009 08:25:09 +0300
Message-ID: <4A77C635.7020606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4943948243527471379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm getting following error when compiling the latest git version with
gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3.

cc1: warnings being treated as errors
sim.c: In function =E2=80=98sim_op_retrieve_cb=E2=80=99:
sim.c:347: error: ignoring return value of =E2=80=98write=E2=80=99, declare=
d with
attribute warn_unused_result
sim.c: In function =E2=80=98sim_op_info_cb=E2=80=99:
sim.c:473: error: ignoring return value of =E2=80=98write=E2=80=99, declare=
d with
attribute warn_unused_result
make[2]: *** [sim.o] Error 1

Regards,
Marko

--===============4943948243527471379==--

