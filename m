Content-Type: multipart/mixed; boundary="===============4292703596212801096=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: Re: [PATCH 2/2] hfp_ag_bluez5: add codec negotiation support
Date: Tue, 13 Oct 2015 12:05:13 +0200
Message-ID: <561CD759.4090109@canonical.com>
In-Reply-To: <561BDA6E.2040208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4292703596212801096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey Denis,

thanks for your review!

> In general we prefer to separate patches per directory.  See HACKING,
> Submitting Patches section.

Will fix that.

> Do we really need this?  It might be simpler to just always support
> codec negotiation if the AG emulator is created with version >=3D 1.6

We can do that but then have to pass the HFP version we're going to run =

with ofono_emulator_create.

> If you include drivers/atmodem/atutil.h you can skip this and...

I thought about this before but that also requires me to include =

gatchat/gatresult.h and gatchat/gatchat.h ... Best would be we move =

those defines to a common place like src/common.h or so.

> As mentioned before, we probably should just always support this by
> default.  Especially since you need to also turn on the SDP WideBand
> feature bit as well, which is more or less static.

I agree with that but we should still bind this to the profile version.

> The function call depends on both the AG & HF feature bits.  Also, the
> spec notes that:
>
> "The AG shall initiate a Codec Connection only if the HF has indicated
> support for the Codec Negotiation feature and has sent at least one
> AT+BAC on the current service level connection. When selecting which
> codec to use for a codec connection, the AG shall use the information on
> codecs available in the HF as provided in the most recently received
> AT+BAC."
>
> So the ofono_emulator_codec_negotiation_supported() should take that
> fact into account.

Will fix that.

> Is calling this from inside g_idle_add really necessary?  card_connect
> is using Non-Blocking connect anyway.

The idea was to ensure that the OK always goes out first before we open =

the SCO connection. Will add a comment to make this a bit more visible.


> Any pending D-Bus requests might be never replied to here...  According
> to the spec this situation is impossible, but still...

We already replied at this point! There are two cases where we end up in =

bcs_cb.

1. We trigger codec negotiation from hfp16_card_connect with a call to =

ofono_emulator_start_codec_negotation. If that call succeeds we reply to =

org.ofono.HandsfreeAudioCard.Connect and also when it fails we do. We =

don't bind the success of the connect call here to the codec negotiation.

2. When the remote side sends us the AT+BCC command we start the codec =

negotiation and the same as mentioned in 1. applies.

However as I am thinking right now about this is not correct. The =

documentation of the org.ofono.HandsfreeAudioCard.Connect method says:

  Attempts to establish the SCO audio connection.
  The Agent NewConnection() method will be called
  whenever the SCO audio link has been established.  If
  the audio connection could not be established, this
  method will return an error.

So we have to wait for codec negotiation to finish before we can reply.

Will fix that too.

> Do you want to call ofono_handsfree_card_set_codec() here?

Done.

> What does the card have to do with this? Proceed with codec negotiation
> regardless and just don't connect SCO if there's no audio card.

Done.

> Why is this check necessary?

Can be dropped as CVSD is mandatory even if codec negotiation has failed.

regards,
Simon


--===============4292703596212801096==--

