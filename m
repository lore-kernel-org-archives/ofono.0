Content-Type: multipart/mixed; boundary="===============4030541559907088586=="
MIME-Version: 1.0
From: Ming Li Wu <mingli@southpole.se>
Subject: Re: [PATCH 1/3] Support Telit cdc acm device
Date: Mon, 17 Dec 2012 19:39:40 +0100
Message-ID: <50CF66EC.7030408@southpole.se>
In-Reply-To: <50CF4992.4080209@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4030541559907088586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
>> +    /* This is for Telit HE910. */
>> +    if(udevng_match_modem_id(modem, "1bc7", "0021")){
>> +        options =3D g_hash_table_new(g_str_hash, g_str_equal);
>> +
>> +        if (options =3D=3D NULL)
>> +            return NULL;
>> +
>> +        g_hash_table_insert(options, "Baud", "115200");
>> +        g_hash_table_insert(options, "Parity", "none");
>> +        g_hash_table_insert(options, "StopBits", "1");
>> +        g_hash_table_insert(options, "DataBits", "8");
>> +        g_hash_table_insert(options, "XonXoff", "off");
>> +        g_hash_table_insert(options, "Local", "on");
>> +        g_hash_table_insert(options, "RtsCts", "on");
>> +    }
>> +
>> +    channel =3D g_at_tty_open(device, options);
>> +    if(options){
>> +        g_hash_table_destroy(options);
>> +    }
>> +
>
> This was already taken care of by the patch from Christopher that was =

> applied today.
>

I have two questions about settings of serial ports:

1. Are the following settings necessary?
         g_hash_table_insert(options, "XonXoff", "off");
         g_hash_table_insert(options, "Local", "on");
         g_hash_table_insert(options, "RtsCts", "on");

2.Should settings of modem port and aux port be different?


Thanks!

Mingli

--===============4030541559907088586==--

