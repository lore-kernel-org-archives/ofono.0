Content-Type: multipart/mixed; boundary="===============8836118675079998551=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] hfp: Add faked sim driver to support SIM ready
Date: Mon, 30 Aug 2010 19:54:25 -0400
Message-ID: <1283212465.6841.96.camel@localhost.localdomain>
In-Reply-To: <4C7C0B8C.40702@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8836118675079998551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > HFP modem doesn't have IMSI at all. In order to notify SIM ready to the
> > core, we create a special sim driver with a faked IMSI number.
> =

> Can you try after commit 88024972df46d4ababbaf39354615e8a8d603cfc?  I
> added magic which will skip sim_ready stuff completely for modems that
> do not add a sim atom.

I would really prefer this. I think faked IMSI's are not a good idea at
all.

Regards

Marcel



--===============8836118675079998551==--

