Content-Type: multipart/mixed; boundary="===============2709851445149636723=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 2/2] gatmux: disable destroy notification on read watcher
Date: Tue, 08 Oct 2019 14:49:29 -0500
Message-ID: <10c3c710-9e03-bb5b-2717-124121738b3e@gmail.com>
In-Reply-To: <20191008184441.7410-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2709851445149636723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 10/8/19 1:44 PM, Martin Hundeb=C3=B8ll wrote:
> With the reference in place in received_data(), the address sanitizer
> now encounters a use-after-free when the destroy notification is
> dispatched for the read watcher (see below).
> =

> Fix this by remove the destroy notification callback, as it isn't really
> used except in the shutdown function.
> =


Okay, this is finally coming back to me.  So glib does indeed wait until =

after the source callback has completed to call the destroy function. =

We have dealt with this in a slightly different way, see GAtIO for =

details.  But I'm fine with this approach as well.

Applied, thanks.

Regards,
-Denis
--===============2709851445149636723==--

