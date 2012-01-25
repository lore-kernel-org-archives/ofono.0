Content-Type: multipart/mixed; boundary="===============1596072038897250880=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: crash when unplugged modem when it was still initializing
Date: Wed, 25 Jan 2012 16:23:56 +0200
Message-ID: <CAHiDW_HE+xMaBYSkYqaNN+we7ZU5-ovRJzFHiZPsL7j3r=o=Jw@mail.gmail.com>
In-Reply-To: <4F1EEBFC.1020203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1596072038897250880==
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
>> starting ofonod s othose were red herrings. In fact I hadn't touched
>> anything for a moment: connmand and ofonod were both running.
>>
>
> Try the following patch.

Actually I just figured out a way to reproduce this pretty consistently:
* plug in modem, wait until it settles
* kill ofonod if running, restart it, wait until it settles (mine is
waiting for a pin entry)
* unplug modem

I confirm that it's hitting sim_spn_close() before spn stuff is
initialized, and that your patch prevents the crash.

 - Jussi

--===============1596072038897250880==--

