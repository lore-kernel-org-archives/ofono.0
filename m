Content-Type: multipart/mixed; boundary="===============3441418356698851262=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Thu, 13 Jan 2011 11:08:16 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4140D5200@008-AM1MPN1-002.mgdnok.nokia.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802D59FD7@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3441418356698851262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 13 Jan 2011, Jeevaka.Badrappan(a)elektrobit.com wrote:
>> CTM is a property of a voice call. And this makes sense as
>> TTY calls _are_ essentially voice calls, with just a bit
>> indicating to the network that the voice circuit should be
>> free of any transcoder/audioprocessing/etc that is not
>> compatible with CTM. And this is negotiated as part of
>> standard call setup (same way as supported codecs).
> =

> I agree but ofono_voicecall_tty_notify is to inform the
> ME(MO originated ME) that the call is accepted as a TTY call on
> the remote side.

yup. So this is needed as it's possible that the established
voice channel is not fully CTM-compatible (either because of
network reasons, or because the called party does not have =

a TTY device attached, or does not have TTY support at all). In
this case, the TTY property for the call would be FALSE (even
if a TTY was attempted).

And this is still standard procedure (applies to all GSM modems
supporting CTM).


--===============3441418356698851262==--

