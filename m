Content-Type: multipart/mixed; boundary="===============1523964461339388673=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Additional info for failed SAT-Send USSD case 
Date: Wed, 29 Sep 2010 05:28:15 -0700
Message-ID: <1285763296-7208-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1523964461339388673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch handles the SAT initiated Send USSD failure case. =

As per the 3GPP 31.111 specification section 6.4.12, when a SAT initiated =

Send USSD fails, error code from the network should be sent as =

additional information(part of Result data). If no additional information
can be sent, then 0( No specific cause can be given) should be sent.

 Due to the current limitations, this patch sends "No Specific cause can be =

givent" to the SAT.

Regards,
jeevaka

--===============1523964461339388673==--

