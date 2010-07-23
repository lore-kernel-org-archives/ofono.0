Content-Type: multipart/mixed; boundary="===============9001030218150025044=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 12/20] struct tx_queue_entry: add a destructor
Date: Fri, 23 Jul 2010 18:14:49 -0500
Message-ID: <4C4A2269.1050404@gmail.com>
In-Reply-To: <1279926662.26204.142.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9001030218150025044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

>> tx_queue_entry * here.  Casting the destructor in g_foo_foreach is
>> acceptable.
> =

> Heh, I'd rather have it like this: Repeat after me in a 1000-loop: casts
> are evil and should be avoided for they muck the code by hiding warnings
> when you change things and miss updating all the sites ... =

> =


I fully agree, but the extra silly NULL argument makes this worse than
the cast.  And to be clear, g_foo_foreach is about the only place we
explicitly allow casts.  If you feel you need to be pedantic, then write
a GFunc specifically to do the foreach bit.

e.g. tx_queue_entry_free(struct tx_queue_entry *);

txq_foreach_free(gpointer foo, gpointer user)
{
  struct tx_queue_entry *bar =3D foo;
  tx_queue_entry_free(bar);
}

Regards,
-Denis

--===============9001030218150025044==--

