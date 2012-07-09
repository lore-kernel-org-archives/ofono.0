Content-Type: multipart/mixed; boundary="===============6180341229497201822=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test-ussd becomes send-ussd
Date: Mon, 09 Jul 2012 11:26:17 -0500
Message-ID: <4FFB0629.9070304@gmail.com>
In-Reply-To: <1341243924-9257-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6180341229497201822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 07/02/2012 10:45 AM, Philippe Nunes wrote:
> ---
>   test/send-ussd |   75 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   test/test-ussd |   75 -------------------------------------------------=
-------
>   2 files changed, 75 insertions(+), 75 deletions(-)
>   create mode 100755 test/send-ussd
>   delete mode 100755 test/test-ussd
>

Why don't we just get rid of test-ussd and create a new send-ussd script =

that doesn't do any stdin handling.  Something along the lines of:

ss.GetProperties()

if state =3D=3D 'idle'
	rsp =3D ss.Initiate()
elif state =3D=3D 'user-response'
	rsp =3D ss.Respond()

print response

And perhaps another ussd related script that just cancels the request. =

Would this satisfy your requirements?

Regards,
-Denis

--===============6180341229497201822==--

