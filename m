Content-Type: multipart/mixed; boundary="===============1101531609136141913=="
MIME-Version: 1.0
From: Kukkonen, Jussi <jussi.kukkonen@intel.com>
Subject: Re: crash after SimManager.ResetPin()
Date: Tue, 27 Dec 2011 13:12:24 +0200
Message-ID: <CAHiDW_FPCpx+SF5jV53nr5pttjzSjtpcG9UzmJQbAd+HHr6c4g@mail.gmail.com>
In-Reply-To: <4EF42DAC.9080204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1101531609136141913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2011 at 9:28 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Jussi,
>
> On 12/23/2011 12:48 PM, Kukkonen, Jussi wrote:
>> Hi all,
>>
>> I consistently get a crash when calling SimManager.ResetPin ("puk",
>> puk, new_pin). Before this I've called ChangePin() =C2=A0with wrong pin
>> three times.to get "PinRequired=3Dpuk" property change.
>>
>> This is a huawei E1550 USB modem.
>>
>
> Can you please try the following patch?
>
> Regards,
> -Denis

That works nicely, I cannot reproduce the crash with your patch. thanks.

Jussi

--===============1101531609136141913==--

