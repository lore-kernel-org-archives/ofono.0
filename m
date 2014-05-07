Content-Type: multipart/mixed; boundary="===============5110525844613956770=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/1] he910: reset modem after IO disconnect
Date: Wed, 07 May 2014 11:28:03 -0500
Message-ID: <536A5F13.3080405@gmail.com>
In-Reply-To: <1399464841-23097-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5110525844613956770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

<snip>
>
> This patch also addresses a secondary issue whereby killing ofono during
> an active connection causes the AUX port to report HUP when ofono is
> restarted.
> =


I'm not quite sure how this patch would fix the above.  The order of
events is the same between kill/restart and a modem reset.  I guess the
only difference is that you don't send a CFUN=3D4 during a modem reset.

> How about this approach instead?  Using ofono_modem_reset has pretty
> much the same effect as my previous patch and _feels" correct...

ofono_modem_reset is intended for firmware crashes and getting back to
previous state quickly.  This is a creative hack, but has some
side-effects you might not intend (e.g. the modem might go online
without being told explicitly)

I don't really mind the patch, but would explore the 'proper' avenues
(e.g. ofono_sim_inserted_notify) first.

Regards,
-Denis

--===============5110525844613956770==--

