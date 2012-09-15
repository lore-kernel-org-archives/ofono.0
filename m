Content-Type: multipart/mixed; boundary="===============1710148661308585507=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: ofono exits after DBUS error
Date: Sat, 15 Sep 2012 11:20:31 +0200
Message-ID: <CABvLYuBcjxmc2a4ZUwYj36qbpJrvkuHfL7sQU2+arGW=Yt2cTw@mail.gmail.com>
In-Reply-To: <505358EF.8000305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1710148661308585507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I know the modem is buggy. But oFono could skip invalid characters,
this would be better then exiting.

Actually the output should be "Mobile Vikings" :-) (but this is
another bug in the modem). So "BASE" would be the correct output for
oFono.

Thanks,
Cedric


On Fri, Sep 14, 2012 at 6:18 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Cedric,
>
>
> On 09/14/2012 08:41 AM, Cedric Jehasse wrote:
>>
>> Hi,
>>
>> It looks like "AT+COPS?" returns an invalid character. I guess this is
>> passed to DBUS which causes oFono to exit.
>>
>
> Correct, but looks like the modem is doing something stupid.
>
>
>> ofonod[10318]: PCUI:>  AT+COPS?\r
>> ofonod[10318]: PCUI:<  \r\n+COPS: 0,0,"BASE\241",2\r\n\r\nOK\r\n
>
>
> I have no idea what it is sending out, but in theory COPS responses are
> limited to IRA characters.  \241 is clearly not.
>
> The question is, what should the output look like?
>
> Regards,
> -Denis

--===============1710148661308585507==--

