Content-Type: multipart/mixed; boundary="===============6403301273731867929=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] text-telephony: add public header
Date: Mon, 29 Nov 2010 07:53:17 -0600
Message-ID: <4CF3B04D.4080704@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157E6BCB6@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6403301273731867929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

On 11/27/2010 03:04 PM, Bastian, Waldo wrote:
>>> +	void (*remove)(struct ofono_ctm *tt);
>>> +	void (*query_tty)(struct ofono_ctm *tt,
>>> +				ofono_ctm_query_cb_t cb,
>>> +				void *data);
>>> +	void (*set_tty)(struct ofono_ctm *tt,
>>> +				int enable,
>>
>> I also changed this to ofono_bool_t enable
> =

> Fyi, I noticed that radio-settings.h has this as an int as well:
> =

> 67         void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
> 68                                 int enable,
> 69                                 ofono_radio_settings_fast_dormancy_set=
_cb_t,
> 70                                 void *data);
> =

> The query callback otoh uses ofono_bool_t.
> =


Thanks for pointing this out.  It has now been fixed.

Regards,
-Denis

--===============6403301273731867929==--

