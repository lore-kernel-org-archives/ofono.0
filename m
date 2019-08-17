Content-Type: multipart/mixed; boundary="===============7918501113969208309=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Sat, 17 Aug 2019 16:09:25 +0200
Message-ID: <4f986d7d-e3b7-a3e3-eeff-df0b848f3438@norrbonn.se>
In-Reply-To: <CAA=hcWTb79iKcxmuCxBK59ybuegAv37i0e4UCf176wcSDrEr=w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7918501113969208309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi JH,

On 17/08/2019 13:55, JH wrote:
> On 8/17/19, JH <jupiter.hce@gmail.com> wrote:
>> On 8/16/19, Daniel Wagner <wagi@monom.org> wrote:
>>> The NTP code is just telling it can't reach the server. This has no
>>> direct connenction to the next entry.
>>
>> So that from NTP, don't need to worry about it.
>>
>>> This message is from the kernel via RTNL interface. The kernel tells
>>> ConnMan the interface state has changed.
>>
>> OK, all from kernel, what could make the kernel to delete the link?

What does the kernel log show?

>>
>>
>>>> connmand[213]: Skipping disconnect of /ubloxqmi_0/context1, network is
>>>> connecting.
>>>> connmand[213]: ipconfig state 2 ipconfig method 1
>>
>>> Your log does not contain the debug information (connmand -d).
>>
>> I attached two log files running in debug, doesn't seem
>>
>> $ OFONO_QMI_DEBUG=3D1 ofonod -d
>>
>> $ connmand -d
> =

> Oops, pressed wrong key, both debug log files attached, looks even
> less information from running ofono -n and connman -n by systemd.
> =


It looks like you've multiple instances of connman and ofono running =

there, that's why you've got nothing in the logs.  Give this another try.

/Jonas

--===============7918501113969208309==--

