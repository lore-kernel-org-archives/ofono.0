Content-Type: multipart/mixed; boundary="===============8583957743335010341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] stk: Add menu related utilities.
Date: Fri, 23 Jul 2010 14:10:48 -0500
Message-ID: <4C49E938.2030509@gmail.com>
In-Reply-To: <1279798973-6612-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8583957743335010341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +static struct stk_menu *stk_menu_create(const char *title,
> +		const struct stk_text_attribute *title_attr, GSList *items,
> +		const struct stk_item_text_attribute_list *item_attrs,
> +		const struct stk_items_next_action_indicator *next_action,
> +		int default_id, gboolean soft_key, gboolean has_help)
> +{

I suggest breaking up this giant constructor with many arguments into
two functions.  One that takes a setup_menu object and one that takes a
select_item object.  Then fills in the items appropriately.

Regards,
-Denis

--===============8583957743335010341==--

