Content-Type: multipart/mixed; boundary="===============2484590668697401076=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: crash when unplugged modem when it was still initializing
Date: Wed, 25 Jan 2012 15:07:27 +0200
Message-ID: <CAHiDW_GaVDhHc29-DvYrDaikechbb7y3MUzZKUQWHZ9oirz7ww@mail.gmail.com>
In-Reply-To: <4F1EEBFC.1020203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2484590668697401076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2012 at 7:35 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> On 01/24/2012 03:33 PM, Jussi Kukkonen wrote:
>> On Tue, Jan 24, 2012 at 11:19 PM, Jussi Kukkonen
>> <jussi.kukkonen@intel.com> wrote:
>>> Hi,
>>> I happened to unplug my dongle quite soon after starting ofono. It
>>> promptly aborted.
>>
>> and it just happened again with no relation to unplugging devices or
>> starting ofonod so those were red herrings. In fact I hadn't touched
>> anything for a moment: connmand and ofonod were both running.
>>
>
> Try the following patch.

Unfortunately today I have not been able to reproduce this, even
without the patch.

I bet the problem was exposed by the constant usb device
appearance/disappearance that I described in the other thread, it
really exercised ofono/connman (found four different segfaults...).
Now that I've figured out a way to keep that from happening I haven't
seen this problem again (it seems the dongle magically starts working
when I connect it using a USB hub in the laptop dock -- this explains
why I would only see the problem when working from home).

I'll try leaving the modem connected via the laptop USB ports to
'stress test' when I can, but I have my own bugs that I can only work
on if I have a working modem, ofono and connman ...  so reproducing
this might not happen right away..

 - Jussi

--===============2484590668697401076==--

