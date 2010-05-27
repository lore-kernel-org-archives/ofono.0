Content-Type: multipart/mixed; boundary="===============9016072198830140886=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Add: set_online and post_online methods to isimodem
 driver
Date: Wed, 26 May 2010 21:08:36 -0500
Message-ID: <201005262108.37085.denkenz@gmail.com>
In-Reply-To: <1274885889-11479-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9016072198830140886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> +static bool mtc_state_cb(GIsiClient *client, const void *restrict data,
> +				size_t len, uint16_t object, void *opaque)

We don't use bools in oFono, please fix this to use gboolean or an int.

Regards,
-Denis

--===============9016072198830140886==--

