Content-Type: multipart/mixed; boundary="===============5701387640959824151=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Wed, 18 Dec 2019 17:08:02 +0000
Message-ID: <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
In-Reply-To: <20191216091521.reh2urr25husschv@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5701387640959824151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On 12/16/19 3:15 AM, Pali Roh=C3=A1r wrote:
> Hi!
> =

> On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
>> Hi Pali,
>>
>> On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
>>>
>>> On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
>>>> On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
>>>>> I think hsphfpd should be part of bluetoothd, but if that's not
>>>>> possible, then that's not possible.
>>>>
>>>> I do not know if bluez developers are interested in having this code as
>>>> part of bluez project, specially when in bluez4 HFP profile was there
>>>> and in bluez5 was HFP code completely removed.
>>>
>>> Hello, could someone from bluez developers comment this Tanu's point?
>>
>> I would have to say no, we are definitely not interested in yet
>> another daemon for AT parsing, we actually have too many of these
>> around, either in a form of Modem Manager, oFono, etc.
> =

> Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
> implementing logic around HSP and HFP profiles and export either native
> interfaces (linux uinput) or DBus interfaces for features provided by
> HSP and HFP specifications and also for current and future vendor
> extensions. And part of this HSP/HFP implementation is of course needed
> parsing and interpreting some of AT commands. Look into my design and
> API proposal. Current daemons which provides AT parsing (like ofono or
> modem manager) are not suitable for for whole HSP and HFP profiles with
> all those extensions (like all possible ways for reporting battery
> level), so for HFP is needed some of custom AT parser.

I'm not sure what logic around HSP you really care about.  It is just a =

single button press in the end.

For HFP, oFono can already support all sorts of extensions.  See for =

example how we handled Siri for HFP support in oFono here:
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/siri-api.tx=
t. =

  Many of the extensions you talked about are also relevant for real =

modems as well (like battery reporting, call volume, etc).  Some of =

these APIs are already defined in fact.

Given the above, oFono upstream has no interest in adding or maintaining =

support this new framework.

Regards,
-Denis
--===============5701387640959824151==--

