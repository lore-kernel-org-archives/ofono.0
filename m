Content-Type: multipart/mixed; boundary="===============5374467324375461982=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Fri, 09 Jul 2010 19:28:23 -0300
Message-ID: <1278714503.10421.152.camel@localhost.localdomain>
In-Reply-To: <1278712419.2327.170.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5374467324375461982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> > Maybe we're not talking about the same thing.  My workflow is
> > =

> > git commit / git am
> > git fetch
> > git rebase
> > git push
> =

> gee, didn't see this -- well, if the rebase is changing the commit IDs,
> which it probably does, then you are breaking the commit history. Would
> depend on the details.
> =

> Anyway, I am not so sure that is the problem. Spent the whole day going
> around it and I still couldn't figure the sucker out. Will keep trying.

the ofono.git master tree never got re-based. All commit ids are fully
atomic. So that is not the problem.

Regards

Marcel



--===============5374467324375461982==--

