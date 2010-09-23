Content-Type: multipart/mixed; boundary="===============6095908280283437375=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix test-sms.
Date: Thu, 23 Sep 2010 11:14:56 +0900
Message-ID: <1285208096.20811.62.camel@localhost.localdomain>
In-Reply-To: <1285182518-15932-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6095908280283437375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Allow user to set SRR and SMSC.
> ---
>  test/send-sms |   23 +++++++++++++++++------
>  1 files changed, 17 insertions(+), 6 deletions(-)
> =

> diff --git a/test/send-sms b/test/send-sms
> index bd1fae5..19d0e35 100755
> --- a/test/send-sms
> +++ b/test/send-sms
> @@ -14,11 +14,22 @@ path =3D modems[0][0]
>  manager =3D dbus.Interface(bus.get_object('org.ofono', path),
>  					'org.ofono.MessageManager')
>  =

> +smsc =3D None
> +
> +if sys.argv[1] =3D=3D "--smsc":
> +	smsc =3D sys.argv[2]
> +	del sys.argv[1:2]
> +
> +if sys.argv[1].startswith("--smsc=3D"):
> +	smsc =3D sys.argv[1].split("=3D", 2)[1]
> +	del sys.argv[1]
> +
> +if smsc:
> +	manager.SetProperty("ServiceCenterAddress", dbus.String(smsc))

the SMSC is a global message manager property, I prefer to just have a
test script that just modifies it. Using set-service-center-address
would be way better then trying to include this in this test script.

Regards

Marcel



--===============6095908280283437375==--

