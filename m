Content-Type: multipart/mixed; boundary="===============5388385619582322505=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 1/2] stkutil: convert text attributes to html
Date: Tue, 22 Jun 2010 14:00:44 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731ED8F332@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <20100621201716.05a204fc@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5388385619582322505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =




>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Kristen Carlson Accardi
>Sent: Tuesday, June 22, 2010 11:17 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH 1/2] stkutil: convert text attributes to html
>
>On Mon, 21 Jun 2010 19:51:06 -0700
>Kristen Carlson Accardi <kristen@linux.intel.com> wrote:
>
>> On Tue, 22 Jun 2010 00:45:39 +0200
>> andrzej zaborowski <balrogg@gmail.com> wrote:
>>
>> > Can we always end_format() and start_format() when the formatting
>> > changes, and just once instead of in a loop?  Here's a test case that
>> > I'm worried about:
>> >
>> > text is "abc"
>> > attribute 1 (red text) starts at 0, len 2
>> > attribute 2 (blue text) starts at 1, len 2
>> >
>> > the generated html, by my reading will look like this:
>> > <span style=3D"color: red;">a<span style=3D"color: blue;">b</span>c</s=
pan>
>>
>> I ran this test just to make sure, the generated html is not as
>> you fear and is correct (I used different colors though)
>>
>> <html><body><span style=3D"color: #347235;background-color:
>#FFFFFF;">a<span style=3D"color: #0000A0;background-color:
>#FFFFFF;">b</span></span>c</body></html>
>
>Hum, ok, this is not correct.... I see your concern and will fix.

When you fix your current algorithm, can we think about these optimizations=
 at the same time?
1. The attribute overlapping may split the text into undesirable pieces. Th=
at is, we may find opportunities to merge the adjacent ones together at las=
t. =

2. Some embedded attributes may be omitted. Taking your above case as examp=
le, the second "background-color:#FFFFFF" can be omitted.
3. Part of attributes, not the whole, can be merged together. For example: =
<red bold>a</red bold><red italic>b</red italic> "may" (not always bring be=
nefit) be optimized as <red><bold>a</bold><italic>b</italic></red>. =


The target of these optimizations is to make to generated html file as smal=
l as possible. I guess this is a NP-complete problem, and not easy to handl=
e :) =



Regards,
-Yang

--===============5388385619582322505==--

