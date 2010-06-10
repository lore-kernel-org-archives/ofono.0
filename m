Content-Type: multipart/mixed; boundary="===============6319862108099742226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0] Report cell technology capability for Option HSO modems
Date: Thu, 10 Jun 2010 16:51:49 -0500
Message-ID: <201006101651.50176.denkenz@gmail.com>
In-Reply-To: <20100610131957.GA29387@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6319862108099742226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> +	/*
> +	 * OSSYSI can appear after a CREG and netreg isn't updated
> +	 * until the next CREG which can take an undefined long time.
> +	 */
> +	ofono_netreg_status_notify(netreg, nd->status, nd->lac,
> +				nd->ci, nd->tech);

If this is indeed the case, then we might as well give up on using unsolici=
ted =

notifications.  There's no point, simply ask the modem for the current =

technology on every CREG change.

Even using a compound at command is fine, e.g AT_OCTI?;_OUWCTI?

It would be nice if someone from Option actually told us how to use this =

properly.

Regards,
-Denis

--===============6319862108099742226==--

