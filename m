Content-Type: multipart/mixed; boundary="===============4394987492160319382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: enable usage of SIM pass codes longer than 8 digits
Date: Tue, 08 Feb 2011 10:22:11 -0600
Message-ID: <4D516DB3.5040406@gmail.com>
In-Reply-To: <1297169298-26209-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4394987492160319382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/08/2011 06:48 AM, Jussi Kangas wrote:
> ---
> =

> =

> Hi,
> =

> On Tue, 2011-02-08 at 06:17 +0200, Denis Kenzior wrote:
> =

> Why don't we keep things simple.  Modify is_valid_pin to take a pin and
>> a min and max number of digits.
>>
>> gboolean is_valid_pin_with_limits(const char *pin, int min, int max)
>> (feel free to pick some better name)
>>
>> Then just add two functions:
>>
>> __ofono_valid_net_pin(const char *pin)
>> __ofono_valid_sim_pin(const char *pin, enum ofono_sim_password_type type)
>>
>> Stick both in ofono.h / sim.c somewhere
>>
> =

> Right. Here it is. =


I applied your patch, but it did have multiple problems, namely blank
line at EOF in sim.c, mixing tab/space for indentation and a compilation
warning.  I was nice enough and fixed all these for you, but please pay
attention to this the next time.

Regards,
-Denis

--===============4394987492160319382==--

