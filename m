Content-Type: multipart/mixed; boundary="===============8832196772294599118=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: [PATCH 0/1] stk: Handle send ss proactive command
Date: Mon, 13 Sep 2010 16:46:26 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A73BF78@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1284366945-18265-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8832196772294599118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Yang Gu
>Sent: Monday, September 13, 2010 4:36 PM
>To: ofono(a)ofono.org
>Subject: Currently when sending a supplementary service control string via=
 D-Bus, a
>
>
From Yang Gu <yang.gu@intel.com> # This line is ignored.
>From: Yang Gu <yang.gu@intel.com>
>Subject:
>In-Reply-To:
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

I intended to send a description for the patch I sent just now, but seems i=
t failed. Sorry for the inconvenience :(

Below is the description:
This patch is to handle send ss proactive command from SIM. =

Currently when sending a supplementary service control string via D-Bus, a =
series of functions would be called. For example, if we want to send a call=
 barring activatioin string via D-Bus, these functions would be called: uss=
d_initiate()->recognized_control_string()->cb_ss_control()->cb_ss_set_lock_=
callback()->cb_ss_query_next_lock()->cb_ss_query_next_lock_callback(). To h=
andle send ss command from SIM needs to follow the same way as D-Bus, so my=
 target is to try the best to reuse these functions. However, currently the=
se functions take the assumption that the calling is from D-Bus. My solutio=
n is to introduce a data structure named "ofono_ss_req" to replace original=
 "DBusMessage *" parameter. =

Other main changes are to unify the return code of these functions and hand=
le them centrally.

Comments are welcome!


Regards,
-Yang

--===============8832196772294599118==--

