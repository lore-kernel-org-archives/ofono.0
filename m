Content-Type: multipart/mixed; boundary="===============7759287445416396556=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Mon, 10 Jan 2011 18:34:54 +0200
Message-ID: <201101101834.55049.remi.denis-courmont@nokia.com>
In-Reply-To: <4D2B3375.1080907@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7759287445416396556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 10 January 2011 18:27:33 ext Denis Kenzior, you wrote:
> Hi R=C3=A9mi,
> =

> On 01/10/2011 05:21 AM, R=C3=A9mi Denis-Courmont wrote:
> > On Friday 07 January 2011 18:23:25 ext Denis Kenzior, you wrote:
> >> The other question I have is whether we should report this at the
> >> context level or at the ConnectionManager level.  Can different contex=
ts
> >> truly have different bearers?
> > =

> > At least for 3G with HS*PA, I believe we can. In my understanding, HSPA
> > channels are allocated per contexts. Correct me if I'm wrong.
> =

> I don't know, to me it would not make sense to allocate different
> bearers per context, but I'm not an RF engineer.  Do note that at least
> several vendors provide extension commands that report the global active
> bearer, not per context.  For instance, see the Ericsson *CPSB command...

The UI wants to show a single icon for the number of "G's". I would assume =

that's meant to address this use case. Then you don't need to iterate over =
all =

contexts, especially those not allocated through that this particular AT =

serial port.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============7759287445416396556==--

