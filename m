Content-Type: multipart/mixed; boundary="===============4742112229473726871=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 02/19] sms: introduce message ID API
Date: Thu, 05 Aug 2010 16:34:57 -0700
Message-ID: <1281051297.19261.126.camel@localhost.localdomain>
In-Reply-To: <4C5B0127.8050703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4742112229473726871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-08-05 at 13:21 -0500, Denis Kenzior wrote:

> > I still could use clarification on which other fields of the 'struct
> > sms' union you want to have hashed other than the PDU payloads.
> > =

> =

> All of them.  Again, it might be much simpler to do this over the
> fragments when they are in true PDU form.  This can be done in
> sms_assembly and tx_queue_entry_new since they deal with fragments alread=
y.
> =

> Alternatively handling the individual structure fields can be done as wel=
l.

On the RX path, it is not going to be easy to use the raw PDUs to
generate a UUID:

whoever code gets the PDU
  ofono_sms_deliver_notify(PDU)
    PDU decoded into a 'struct sms'
    handle_deliver(struct sms)
      added to fragment list in assembly
      sms_dispatch(fragment list of 'struct sms')

so if we also want to generate a UUID of this based on RAW PDUs, either
we keep the raw PDU around or we base the UUID generation from the
struct sms fields. We could really only generate this at sms_dispatch()
or similar, where we have the fragments in the proper order.

Thoughts?

    =




--===============4742112229473726871==--

