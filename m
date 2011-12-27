Content-Type: multipart/mixed; boundary="===============3608345771005268673=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: crash after SimManager.ResetPin()
Date: Mon, 26 Dec 2011 18:04:22 -0600
Message-ID: <4EF90B86.70409@gmail.com>
In-Reply-To: <CAHiDW_FPCpx+SF5jV53nr5pttjzSjtpcG9UzmJQbAd+HHr6c4g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3608345771005268673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 12/27/2011 05:12 AM, Kukkonen, Jussi wrote:
> On Fri, Dec 23, 2011 at 9:28 AM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Jussi,
>>
>> On 12/23/2011 12:48 PM, Kukkonen, Jussi wrote:
>>> Hi all,
>>>
>>> I consistently get a crash when calling SimManager.ResetPin ("puk",
>>> puk, new_pin). Before this I've called ChangePin()  with wrong pin
>>> three times.to get "PinRequired=3Dpuk" property change.
>>>
>>> This is a huawei E1550 USB modem.
>>>
>>
>> Can you please try the following patch?
>>
>> Regards,
>> -Denis
> =

> That works nicely, I cannot reproduce the crash with your patch. thanks.
> =

> Jussi

Thanks for testing, patch has been pushed upstream.

Regards,
-Denis

--===============3608345771005268673==--

