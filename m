Content-Type: multipart/mixed; boundary="===============5131173252585862499=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/1] Add support to enable/disable specific plugin
Date: Sat, 11 Sep 2010 18:53:32 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352A720CD0@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1284201757.20451.18.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5131173252585862499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holtmann,

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>> Support to load or not load specific plugin when ofono is started.
>> E.g., use 'ofonod -P hfp' to disable hfp plugin.
>> ---
>>  src/main.c |   11 ++++++++++-
>>  1 files changed, 10 insertions(+), 1 deletions(-)
> =

> patch has been applied. I did all the hard work - just forgot to hook
> it up properly ;)

Thanks.

>> -	__ofono_plugin_init(NULL, NULL);
>> +	__ofono_plugin_init(option_plugin, option_noplugin); +
>> +	g_free(option_plugin);
>> +	g_free(option_noplugin);
> =

> Please also send a ConnMan patch to fix the memory leak that ConnMan
> has here actually.

ConnMan does free the string propertly. So we don't need more fixes. :-)

Regards,
Zhenhua

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============5131173252585862499==--

