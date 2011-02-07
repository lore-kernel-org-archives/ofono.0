Content-Type: multipart/mixed; boundary="===============3886860091770074157=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/5 v3] Cell-info: CellInfo DBUS interface definition
Date: Mon, 07 Feb 2011 11:27:10 -0800
Message-ID: <1297106830.1520.445.camel@aeonflux>
In-Reply-To: <1294833919-1510-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3886860091770074157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  include/dbus.h |    1 +
>  src/ofono.h    |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/include/dbus.h b/include/dbus.h
> index 12768f6..f2e18bf 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -45,6 +45,7 @@ extern "C" {
>  #define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
>  #define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistrat=
ion"
>  #define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
> +#define OFONO_CELL_INFO_INTERFACE "org.ofono.CellInfo"
>  #define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
>  #define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
>  #define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
> diff --git a/src/ofono.h b/src/ofono.h
> index cab70cd..820e3a3 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -127,6 +127,7 @@ enum ofono_atom_type {
>  	OFONO_ATOM_TYPE_NETTIME =3D 21,
>  	OFONO_ATOM_TYPE_CTM =3D 22,
>  	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
> +	OFONO_ATOM_TYPE_CELL_INFO =3D 24,
>  };

This is a little bit confusing since the atom enum doesn't really have
to do anything with the D-Bus interface name. You might wanna feed that
into some other patch or split it out.

Regards

Marcel



--===============3886860091770074157==--

