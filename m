Content-Type: multipart/mixed; boundary="===============4183086751819753218=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] add interface property to primary context
Date: Mon, 09 Nov 2009 10:57:15 -0600
Message-ID: <200911091057.16388.denkenz@gmail.com>
In-Reply-To: <1257752281-22251-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4183086751819753218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> @@ -37,6 +37,7 @@ struct ofono_gprs_context;
>  struct ofono_gprs_primary_context {
>  	unsigned int cid;
>  	int direction;
> +	char *interface;
>  	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
>  	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
>  	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];

Logically this does not belong here.  It should be added to =

ofono_gprs_context, or perhaps to pri_context.

Regards,
-Denis

--===============4183086751819753218==--

