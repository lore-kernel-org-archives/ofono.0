Content-Type: multipart/mixed; boundary="===============0755728549350820343=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: ofono_sim_ready_notify()
Date: Tue, 05 Oct 2010 18:57:04 +0200
Message-ID: <1286297824.2588.10.camel@aeonflux>
In-Reply-To: <AANLkTi=W+H0xg8Cy1vZUUnB6vPZYgZhPdaiUVb4Odc-7@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0755728549350820343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> > However you do remember that we had issues when we tried this the first
> > time. It looked simpler on paper then it was when trying to make this
> > work with all modem plugins. Remember that this has to work with all
> > modem plugins and not just ISI or IFX for that matter.
> =

> Yes, this is a very tricky problem. I've sent my first stab to the list.
> =

> The core side is very simple, but the atmodem driver probably needs
> different approach. Perhaps something similar to isimodem with a ready
> flag and indications registered at probe time.

as long as we have a proper fallback for modems that have no indication
whatsoever I am fine. And I think we have a bunch of these cheapo
dongles where we just have to default to SIM ready eventually.

Regards

Marcel



--===============0755728549350820343==--

