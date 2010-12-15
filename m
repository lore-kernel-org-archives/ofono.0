Content-Type: multipart/mixed; boundary="===============2850291352279611352=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] ctm: use ofono_error instead of DBG for errors
Date: Wed, 15 Dec 2010 19:47:04 -0200
Message-ID: <20101215214704.GC3746@vigoh>
In-Reply-To: <87zks6d92v.fsf@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2850291352279611352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

* Neil Jerram <neil@ossau.uklinux.net> [2010-12-15 21:23:20 +0000]:

> "Gustavo F. Padovan" <padovan@profusion.mobi> writes:
> =

> > [PATCH] ctm: use ofono_error instead of DBG for errors
> =

> I'm a newcomer to ofono, and to this list, but in general I'd hope to
> see more explanation/justification of code changes than this patch
> provides.  In other words, why is it better to use ofono_error instead
> of DBG?

This patch fixes situation where we were reporting error in DBG messages.
If we have an error to print it is good to give the right priority to the
message. Just look the patch and you will figure out this.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============2850291352279611352==--

