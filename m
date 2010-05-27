Content-Type: multipart/mixed; boundary="===============7499984638836748325=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] Use ofono_bool_t instead of bool in modem API.
Date: Thu, 27 May 2010 13:01:27 -0500
Message-ID: <201005271301.28486.denkenz@gmail.com>
In-Reply-To: <1274976768-1555-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7499984638836748325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>  int ofono_modem_set_boolean(struct ofono_modem *modem,
> -				const char *key, bool value);
> -bool ofono_modem_get_boolean(struct ofono_modem *modem, const char *key);
> +				const char *key, gboolean value);
> +gboolean ofono_modem_get_boolean(struct ofono_modem *modem, const char
>  *key);

Err, please pay attention.  This should be ofono_bool_t.  I fixed it for yo=
u =

(again).

Regards,
-Denis

--===============7499984638836748325==--

