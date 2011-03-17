Content-Type: multipart/mixed; boundary="===============5972443951871544849=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Limits the send sms retry to network timeout
Date: Thu, 17 Mar 2011 09:36:36 -0700
Message-ID: <1300379798-3390-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5972443951871544849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

  If sending of SMS fails, then oFono core will try to resend it after
n * 5 seconds(n =3D retry count). Due to this, conformance test case
27.22.8 sequence 1.4 fails(refer 31.124 spec). Plan is to limit the
failue codes for which the retry will be done. This patch allows the
retry if the failure is only due to network timeout. For all the other
failure cases, retry is not done.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  sms: limit the sms sending retry

 src/sms.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)


--===============5972443951871544849==--

