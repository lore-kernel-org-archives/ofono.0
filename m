Content-Type: multipart/mixed; boundary="===============8417871384291961327=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Thu, 09 Dec 2010 13:25:43 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A20D08A1C75@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1291847731.4795.204.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8417871384291961327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09 Dec 2010, Marcel Holtmann wrote:
>>  - lots of modems still handle all audio and PA will know nothing
>>    about calls at all with these modems
> =

> actually Denis raised the same question, but then again this is for a
> product specific requirement. And for that product we know that PA will
> do the audio processing.

not really. We need modem adaptation for call counters and need
an API that works with all modems. And I'd assume other handset
vendors need such an API as well (either in oFono or somewhere else).

> Important for me is to weight the extra costs of IO and CPU consumption
> when doing this inside oFono. And since ofonod itself would actually
> not wake up during a phone call, I think this is not a good fit.

I share the concern for the IO/CPU cost, but I don't think it
matters much in which daemon this is done. Especially if some slack is =

allowed for the timers (which should be the case), ofonod will be scheduled =

when the CPU is anyways woken up (e.g. modem/audio interrupts wake up =

pulseaudio). So the big cost of bringing CPU, memories et al online are =

already taken at this point, and the additional cost of running ofonod =

for a while is minimal (compared to waking up some non-realtime thread of =

pulseaudio, or some other component, to do the same).

But yeah, there is a IO/CPU cost in any case, I agree about that.
 =

Br,
-- =

Kai Vehmanen


--===============8417871384291961327==--

