Content-Type: multipart/mixed; boundary="===============5730795722528435850=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 1/3] cdma-connman: add feature to load/save credentials
Date: Thu, 11 Aug 2011 15:15:35 +0200
Message-ID: <4E43D5F7.3000206@linux.intel.com>
In-Reply-To: <4E4181DC.4040306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5730795722528435850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 09/08/2011 20:52, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 08/09/2011 09:48 AM, Guillaume Zajac wrote:
>> ---
>>   include/cdma-connman.h |    3 ++
>>   src/cdma-connman.c     |   57 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   src/modem.c            |   35 +++++++++++++++++++++++++++++
>>   3 files changed, 95 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/cdma-connman.h b/include/cdma-connman.h
>> index 6a1c9ff..0f8e388 100644
>> --- a/include/cdma-connman.h
>> +++ b/include/cdma-connman.h
>> @@ -77,6 +77,9 @@ void ofono_cdma_connman_set_data(struct ofono_cdma_con=
nman *cm,
>>   						void *data);
>>   void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
>>
>> +void ofono_cdma_connman_load_credentials(struct ofono_cdma_connman *cm,
>> +					const char *serial);
>> +
> Stop right there, this is pretty much the wrong design.  In fact it is
> completely opposite of what you want to have from an encapsulation / API
> point of view.
>
> You need to ensure that the imsi/meid are known prior to cdma-connman
> going live.  That way the cdma-connman atom can lookup the relevant
> information and load its settings as needed.
>
> If that means that the modem needs to query the relevant information
> prior to calling post_sim/post_online, then that is what you have to do.
>

What about using a __ofono_devinfo_add_serial_watch() similar to =

__ofono_netreg_add_status_watch()?
cdma-connman atom would be notified when credentials can be loaded.

Kind regards,
Guillaume

--===============5730795722528435850==--

