Content-Type: multipart/mixed; boundary="===============8028704407622023490=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 1/2] hfp_hf: Fix not creating modem during NewConnection
Date: Fri, 28 Apr 2017 10:03:01 +0300
Message-ID: <CABBYNZKBnsFqeLRSrvjKb36b44eDE8jF9LTTkHfwpF6xViH2Pg@mail.gmail.com>
In-Reply-To: <5a661f21-e36c-695f-ffdc-78ba98af49d1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8028704407622023490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 27, 2017 at 9:28 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Luiz,
>
> On 04/27/2017 07:55 AM, Luiz Augusto von Dentz wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> In case the UUIDs are not updated, or are still being resolved, when
>> Paired property changes a modem will never be registered.
>
>
> I can sort of see the 'still being resolved' issue.  But what is the 'not
> updated' part?

I guess I meant 'as they are still being resolved', I will fix it in
the next revision.

>>
>> In order to fix this problem allow modems to be registered directly
>> during NewConnection.
>
>
> Wouldn't it be better to track the UUIDs property changes as well and
> register the modem when this changes?  Otherwise the AG side might be able
> to trigger a connection, but not vice-versa.

We could in fact use the ServiceResolved signal that got introduced
exactly to tell when BlueZ is done resolving services, though that got
introduce just recently so we might need this change as well to be
save against older versions of BlueZ.

>> ---
>>  plugins/hfp_hf_bluez5.c | 193
>> +++++++++++++++++++++++++-----------------------
>>  1 file changed, 102 insertions(+), 91 deletions(-)
>>
>
> Regards,
> -Denis
>



-- =

Luiz Augusto von Dentz

--===============8028704407622023490==--

