Content-Type: multipart/mixed; boundary="===============4765614373584588484=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Reliable SMS receive
Date: Sat, 02 Feb 2019 09:42:19 -0600
Message-ID: <c015e80d-42c2-c9d3-4141-86f5f4c421e9@gmail.com>
In-Reply-To: <20190201220554.GB13090@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4765614373584588484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 02/01/2019 04:05 PM, Pavel Machek wrote:
> Hi!
> =

> I see that great care is taken not to lose outgoing message: "
> Persisting of outgoing SMS messages.  Whenever oFono is asked to send
> an SMS message, it adds it to an internal queue and persists it on
> disk.  The queue is persistent across reboots of oFono and allows to
> queue SMS messages even while the modem is offline."
> =

> Is there something similar possible for incoming messages? I really
> hate losing those... Best think would be if

So fundamentally oFono is only responsible for messages 'in-transit'. =

So it takes great care to ensure it doesn't lose these, as you already =

pointed out.  This goes for outgoing messages as well as incoming ones =

while they're being de-fragmented & reassembled.

Once a message has been fully received and handed off to the history =

plugin, oFono's responsibility ends.

> =

> a) SMS comes from the modem
> =

> b) ofono sends the SMS over the dbus
> =

> c) application writes it to stable storage, and confirms that back on
> dbus
> =

> d) ofono confirms reception of SMS to the modem.
> =

> e) modem confirms it to the network.

That is not how this works.  oFono performs full reassembly of all SMS =

fragments.  The application receives the message only once it has been =

fully reassembled.  It has no control over acks, oFono does this =

automatically.  Besides, most modems don't really support this properly =

anyway.

> =

> If something goes wrong, network will retransmit message and it will
> be delivered on the next boot.
> =

> (Other schemes would work for me, too...)
> =

> Ideas?

Write a history plugin that persists your messages in permanent storage =

if you're worried about losing them over D-Bus.

Regards,
-Denis

--===============4765614373584588484==--

