Content-Type: multipart/mixed; boundary="===============4210322777000293280=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] avoid stk atom is removed when sim pin is blocked
Date: Thu, 12 Sep 2013 08:32:15 -0500
Message-ID: <5231C25F.3090508@gmail.com>
In-Reply-To: <DA62CA5DDF4CA640AA25B1684E5D141101D85F53@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4210322777000293280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 09/11/2013 08:14 PM, Zhang, Caiwen wrote:
>
> Hi Denis,
>
>>> When sim pin is blocked after input wrong pin code three times, modem
>>> will change to pre-sim status, at this time, STK function should be
>>> available. stk atoms shouldn't be removed.
>>
>> Can you please provide a reference to a 3GPP / ETSI document which states
>> that this is the case?
>
> I don't see any spec states STK should be available or unavailable when S=
IM PIN is blocked.
> But all the modems of many different manufacturers I ever used keep STK a=
vailable after SIM PIN is blocked.
>
> Here if we remove stk atom and recreate it after pin is reset, stk functi=
on will be unusable.

Again, please elaborate.  Much of Sim Toolkit depends on access to files =

that can only be accessed with PIN entered.  So leaving STK atom in a =

fully functional state is not the answer either.

Why would stk be unusuable.  Is it that we cannot recover the Main Menu =

state after re-creating it?

Regards,
-Denis

--===============4210322777000293280==--

