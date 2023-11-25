

/* package private */ class string_utils;


  // This needs to be declared as a dynamic array[$] (not a static array[] with a fixed length)
  /* local */ typedef string array_of_string[$];  


  static function array_of_string split_by_char(input string c, input string s);

    string parts[$];              // Dynamic array of strings

    int last_char_position = -1;

    if (c.len() != 1) begin
      //$fatal(0, "Internal error: expected a single character string");
      __svunit_fatal( "Internal error: expected a single character string");
    end

    for (int i = 0; i < s.len(); i++) begin
      if (i == s.len()-1)
        parts.push_back(s.substr(last_char_position+1, i));
      if (string'(s[i]) == c) begin
        parts.push_back(s.substr(last_char_position+1, i-1));
        last_char_position = i;
      end
    end

    return parts;
  endfunction

endclass

