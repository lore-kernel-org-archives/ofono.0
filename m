Content-Type: multipart/mixed; boundary="===============0124381298388036932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono and BT interaction
Date: Fri, 10 Sep 2010 10:30:26 -0500
Message-ID: <4C8A4F12.3080409@gmail.com>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F46D581EF8D@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0124381298388036932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

On 09/10/2010 09:35 AM, Berthier, Emmanuel wrote:
> Hi Marcel,
> =

>>>> If you power on the HFP modem. If not, then oFono will do nothing.
>>>
>>> Yes, that's one solution. How to do that at BlueZ level?
>>
>> no idea actually.
>>
>>>> You can always start ofonod with -P hfp and then the HFP support shoul=
d be
>>>> ignored. At least that works for testing.
>>>
>>> Very interesting.
>>> I've not found "-P" option in ofono 0.25, nor in the last 0.28 source t=
ree.
>>> Did I miss something?
>>
>> No you didn't. It is a ConnMan feature that we never ported over to
>> oFono. Not a big deal to add, but so far nobody did the work.
> =

> So, the question is still open:
> How can I cut the link between ofono and BlueZ?
> =


I still don't understand what you're trying to accomplish.  If you don't
want to establish an HFP connections, simply don't
Modem.SetProperty("Powered", True).  Or is your issue that ConnMan
automatically powers on the HFP devices?

If you don't want HFP modems to even be seen, disable the hfp plugin.

Regards,
-Denis

--===============0124381298388036932==--

