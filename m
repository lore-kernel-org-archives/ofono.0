Content-Type: multipart/mixed; boundary="===============5637569761392452571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Expose voice call direction synchronously
Date: Tue, 11 Jan 2011 23:14:20 -0600
Message-ID: <4D2D38AC.9010901@gmail.com>
In-Reply-To: <C50CA21D80D6B74F80FB941E215DF4140D3601@008-AM1MPN1-002.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5637569761392452571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

On 01/11/2011 06:47 AM, Kai.Vehmanen(a)nokia.com wrote:
> Hi,
> =

> On 10 Jan 2010, R=C3=A9mi Denis-Courmont wrote:
>> Currently, the call direction can only be inferred from the signals.
>> This adds a property to keep it visible also from GetCalls().
> =

> just adding one more do { ++votes; } while(0) for this.
> telepathy-ring needs this as well when it is (re)started and there
> are existing calls: =

> https://bugs.freedesktop.org/show_bug.cgi?id=3D32990
> =


I'm still waiting for someone to give me a proper usecase for how the
Dialer UI is going to use this information.  Neither the Meego dialer
nor any other dialer I have ever used has provided this information.
Call direction for call history purposes is already provided to the
history plugin.

So right now Section 4.2 of doc/ofono-paper.txt still applies.

Regards,
-Denis

--===============5637569761392452571==--

