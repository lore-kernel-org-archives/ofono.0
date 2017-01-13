Content-Type: multipart/mixed; boundary="===============4354282770390170427=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Regarding multiple APN support in ofono/connman
Date: Fri, 13 Jan 2017 12:32:48 +0100
Message-ID: <3985cb10-22a7-8158-7666-1c6a50043940@monom.org>
In-Reply-To: <733ce497-2a7f-d345-0263-e7f33187dfd8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4354282770390170427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/12/2017 12:26 AM, Denis Kenzior wrote:
> On 01/11/2017 01:39 PM, Naveen Kumar Danturi wrote:
>> Hi Ofono team,
>> Is there a support in ofono for multiple PDN connections in parallel ?
>> If so what interfaces/API's it exposes to connman to manage multiple
>> APN's ? If so, I have these 2 questions :
> =

> Yes, oFono can activate multiple active contexts, assuming the hardware
> & driver supports this.  See doc/connman-api.txt.  This is the same
> interface ConnMan is using currently.  However, ConnMan only manages a
> single context of type=3D"internet".  I think there were some patches for
> ConnMan to support multiple active internet contexts, but I'm not sure
> if they ever were accepted upstream.

Just for the record, ConnMan supports multiple context of type
"internet" now. See 71cbf35ce180cfed27bea6f4b7d1e5792d58f52c in the
ConnMan repo.

cheers,
daniel

--===============4354282770390170427==--

