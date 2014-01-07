Content-Type: multipart/mixed; boundary="===============1475498549040815006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono issue: Reject SCO: Agent not registered
Date: Tue, 07 Jan 2014 10:53:53 -0600
Message-ID: <52CC3121.7080102@gmail.com>
In-Reply-To: <CANhWJ4gCop1pjGr6T4tBJ=iGicCsvqfNnrhr6UqCv3qVv6PJ2Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1475498549040815006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ignazio,

On 01/03/2014 04:16 PM, Ignazio Chiappone wrote:
> Hello everyone,
>
> my goal is to use the bluetooth HFP to make/receive a call, however I
> have a problem with oFono.
> Actually I'm working on Fedora 20 with blueZ 5.12 and oFono 1.14 .
>
> When I start ofonod I see this: http://pastebin.com/AsukjcXx .
>
> Using test script enable-modem, after pair my device with linux,
> everything seems to work fine, on ofonod in debug mode, I see this:
> http://pastebin.com/2GBmZERk .
>
> Now, using my device I try to make/receive a call, but I see in both
> cases this error:
>
> Reject SCO: Agent not registered
> Reject SCO: Agent not registered
> Reject SCO: Agent not registered .
>
> I don't understand if that kind of problem is related to oFono or blueZ,
> because I think it's blueZ duty to establish the SCO link, but the agent
> reported on the error message is a particular blueZ agent or an oFono age=
nt?

Support for HFP actually involves 3 daemons

- BlueZ5 which takes care of pairing, device detection / discovery, etc.
- oFono which takes care of HFP protocol details and establishment of =

the SCO connection
- PulseAudio which transmits / receives the data on the SCO link and =

"plays" it.

It looks like your PulseAudio is either not installed or not the version =

that works with oFono.

The oFono and BlueZ changes for HFP are currently in a 'released' state =

(e.g. part of an official release).  I'm not sure whether the PulseAudio =

changes are...

Regards,
-Denis

--===============1475498549040815006==--

